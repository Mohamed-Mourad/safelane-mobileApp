import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safelane/Screens/RouteDetailsScreens/widgetReuse.dart';
import 'package:safelane/Screens/RouteDetailsScreens/stats.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';
import '../../Shared/components/constants.dart';

class RouteDetailsScreen extends StatelessWidget {

  final String arrivalTime;

  RouteDetailsScreen(this.arrivalTime);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var rating = AppCubit.get(context).routeRating;
        var destination = AppCubit.get(context).destination;
        print(destination);
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, -4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Route Details",
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).deleteRoute();
                                  //Navigator.pushNamed(context, '/map');
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: SLNavy,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xFFF8EDED),
                        thickness: 1.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Arrive at",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: grey,
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                destination,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Arrive by",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: grey,
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                arrivalTime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Safety rating",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: grey,
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ratingStars(rating: rating),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Color(0xFFF8EDED),
                        thickness: 1.0,
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            child: button(
                                width: 150.0,
                                background: SLNavy,
                                border: SLGreen,
                                hasBorder: true,
                                function: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return statsScreen();
                                      },
                                    ),
                                  );
                                },
                                text: "Stats"),
                          ),
                          SizedBox(
                            child: button(
                                width: 150.0,
                                background: MadosGreen,
                                function: () {},
                                text: "Start"),
                          )
                        ],
                      ),
                    ],
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
