import 'package:flutter/material.dart';

import 'package:safelane/Screens/RouteDetailsScreens/activeList.dart';
import '../../Shared/components/constants.dart';

class obstaclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
            height: 400.0,
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
                      SizedBox(
                        width: 40.0,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: SLNavy,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Obstacles",
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: black,
                              fontWeight: FontWeight.bold,
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
                  Expanded(
                    child: ActiveList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}