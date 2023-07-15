import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:safelane/Screens/RouteDetailsScreens/widgetReuse.dart';
import 'package:safelane/Screens/RouteDetailsScreens/obstacles.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';
import '../../Shared/components/constants.dart';

class statsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var dataMap = AppCubit.get(context).dataMap;
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
                                "Stats",
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
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(microseconds: 400),
                        colorList: [
                          Color(0xFF0277BD),
                          Color(0xFF0288D1),
                          Color(0xFF039BE5),
                          Color(0xFF03A9F4),
                          Color(0xFF29B6F6),
                        ],
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          showLegends: true,
                          legendPosition: LegendPosition.right,
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                      ),
                      Divider(
                        color: Color(0xFFF8EDED),
                        thickness: 1.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            child: button(
                                width: 232.0,
                                background: SLNavy,
                                border: SLGreen,
                                hasBorder: true,
                                function: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => obstaclesScreen(),
                                    ),
                                  );
                                },
                                text: "View Obstacles"
                            ),
                          ),
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