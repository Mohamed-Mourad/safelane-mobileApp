import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/components/components.dart';
import '../../Shared/components/constants.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';

class FilterScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
              ),
            ),
            title: const Text(
              'Filter By',
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
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Obstacle Type:',
                      style: TextStyle(
                        color: black,
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: buildFilterObstacleItem(
                    title: 'pothole',
                    onTap: () {
                      AppCubit.get(context).updateObstacleFilters("pothole");
                    },
                    isSelected: AppCubit.get(context).obstacleFilters["pothole"]!,
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: buildFilterObstacleItem(
                    title: 'crack',
                    onTap: () {
                      AppCubit.get(context).updateObstacleFilters("crack");
                    },
                    isSelected: AppCubit.get(context).obstacleFilters["crack"]!,
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: buildFilterObstacleItem(
                    title: 'wet',
                    onTap: () {
                      AppCubit.get(context).updateObstacleFilters("wet");
                    },
                    isSelected: AppCubit.get(context).obstacleFilters["wet"]!,
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: buildFilterObstacleItem(
                    title: 'muddy',
                    onTap: () {
                      AppCubit.get(context).updateObstacleFilters("muddy");
                    },
                    isSelected: AppCubit.get(context).obstacleFilters["muddy"]!,
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Severity:',
                      style: TextStyle(
                        color: black,
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    buildFilterSeverityItem(
                        title: "1",
                        onTap: () {
                          AppCubit.get(context).updateSeverityFilters("1");
                        },
                        isSelected: AppCubit.get(context).severityFilters["1"]!,
                        context: context
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    buildFilterSeverityItem(
                        title: "2",
                        onTap: () {
                          AppCubit.get(context).updateSeverityFilters("2");
                        },
                        isSelected: AppCubit.get(context).severityFilters["2"]!,
                        context: context
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    buildFilterSeverityItem(
                        title: "3",
                        onTap: () {
                          AppCubit.get(context).updateSeverityFilters("3");
                        },
                        isSelected: AppCubit.get(context).severityFilters["3"]!,
                        context: context
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    buildFilterSeverityItem(
                        title: "4",
                        onTap: () {
                          AppCubit.get(context).updateSeverityFilters("4");
                        },
                        isSelected: AppCubit.get(context).severityFilters["4"]!,
                        context: context
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    buildFilterSeverityItem(
                        title: "5",
                        onTap: () {
                          AppCubit.get(context).updateSeverityFilters("5");
                        },
                        isSelected: AppCubit.get(context).severityFilters["5"]!,
                        context: context
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
