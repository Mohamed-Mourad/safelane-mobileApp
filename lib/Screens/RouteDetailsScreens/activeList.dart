import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safelane/Screens/RouteDetailsScreens/widgetReuse.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';

class ActiveList extends StatefulWidget {
  @override
  _ActiveListState createState() => _ActiveListState();
}

class _ActiveListState extends State<ActiveList> {

  int activeIndex = 1;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: activeIndex, viewportFraction: 0.3);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var items = AppCubit.get(context).obstaclesOnRoute;
        return PageView.builder(
          controller: _pageController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            // Calculate the size and opacity based on the item's position
            final double scaleFactor = index == activeIndex ? 1.0 : 0.5;
            final double opacity = index == activeIndex ? 1.0 : 0.5;

            return Center(
              child: SizedBox(
                width: 160.0,
                height: 160.0,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scaleFactor,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(item.obstacleIMG),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            begin: Alignment(0.5,0.0),
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.type,
                                  style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                severityBars(severity: item.severity),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          onPageChanged: (index) {
            setState(() {
              activeIndex = index;
            });
          },
        );
      },
    );
  }
}