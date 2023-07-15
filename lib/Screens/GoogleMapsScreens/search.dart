import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';
import 'package:safelane/Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Screens/GoogleMapsScreens/listTile.dart';

class AutocompleteSearchScreen extends StatefulWidget {
  const AutocompleteSearchScreen({Key? key}) : super(key: key);

  @override
  State<AutocompleteSearchScreen> createState() =>
      _AutocompleteSearchScreenState();
}

class _AutocompleteSearchScreenState extends State<AutocompleteSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final places = GoogleMapsPlaces(apiKey: apiKey);
  TextEditingController textFieldController = TextEditingController();

  List<Prediction> searchResults = [];

  double destinationLat = 0;
  double destinationLng = 0;

  @override
  void dispose() {
    searchController.dispose();
    textFieldController.dispose();
    super.dispose();
    destinationLat = 0;
    destinationLng = 0;
  }

  void searchPlaces(String input) async {
    if (mounted) {
      if (input.isNotEmpty) {
        Position position = await Geolocator.getCurrentPosition();
        final sessionToken = Uuid().v4();

        Location location = Location(
          lat: position.latitude,
          lng: position.longitude,
        );

        PlacesAutocompleteResponse response = await places.autocomplete(
          input,
          types: ['geocode', 'establishment'],
          sessionToken: sessionToken,
          location: location,
          radius: 5000,
        );

        setState(() {
          searchResults = response.predictions;
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    }
  }

  Future getPlaceLocation(String placeId) async {
    PlacesDetailsResponse placeDetail = await places.getDetailsByPlaceId(placeId);
    destinationLat = placeDetail.result.geometry!.location.lat;
    destinationLng = placeDetail.result.geometry!.location.lng;
  }

  void handleLocationSelected(int index) async {
    if (index >= 0 && index < searchResults.length) {
      textFieldController.text = searchResults[index].description ?? '';
      try {
        await getPlaceLocation(searchResults[index].placeId!);
      } catch (e) {
        print("$e");
      }
      await AppCubit.get(context).addDestination(
          destinationLat, destinationLng, textFieldController.text);
      Navigator.popAndPushNamed(context, '/map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (comtext, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  "assets/Images/location.png",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
            title: const Text(
              'Set Location',
              style: TextStyle(
                color: SLNavy,
                fontFamily: "Poppins",
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: grey10,
                child: IconButton(
                  icon: Icon(Icons.close, color: SLGreen),
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: textFieldController,
                    onChanged: (value) {
                      searchPlaces(value);
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Search for a destination",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Image.asset(
                          "assets/Images/pin.png",
                          width: 16,
                          height: 16,
                          color: grey40,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 4,
                thickness: 1,
                color: grey10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) => LocationListTile(
                    location: searchResults[index].description!,
                    onTap: () => handleLocationSelected(index),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
