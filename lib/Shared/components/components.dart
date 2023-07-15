import 'package:flutter/material.dart';
import 'package:safelane/Shared/components/constants.dart';

Widget buildFilterObstacleItem(
    {required String title,
    required Function onTap,
    required bool isSelected,
    required BuildContext context}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
        width: 320.0,
        height: 55.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: grey10,
          borderRadius: BorderRadius.circular(12.0),
          border: isSelected ? Border.all(color: SLGreen, width: 1.0) : null,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: SLGreen,
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                color: black,
                fontFamily: "Poppins",
                fontSize: 16.0,
              ),
            ),
          ],
        )),
  );
}

Widget buildFilterSeverityItem(
    {required String title,
      required Function onTap,
      required bool isSelected,
      required BuildContext context}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
        width: 60.0,
        height: 55.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: grey10,
          borderRadius: BorderRadius.circular(12.0),
          border: isSelected ? Border.all(color: SLGreen, width: 1.0) : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: black,
              fontFamily: "Poppins",
              fontSize: 16.0,
            ),
          ),
        )),
  );
}
