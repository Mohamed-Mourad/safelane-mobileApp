import 'package:flutter/material.dart';
import 'package:safelane/Shared/components/constants.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  final VoidCallback onTap;

  const LocationListTile({Key? key, required this.location, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 0,
          leading: Image.asset(
            "assets/Images/pin.png",
            width: 16,
            height: 16,
          ),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width-25, 
          child: Divider(
            height: 10,
            thickness: 2,
            color: grey10,
          ),
        ),
      ],
    );
  }
}