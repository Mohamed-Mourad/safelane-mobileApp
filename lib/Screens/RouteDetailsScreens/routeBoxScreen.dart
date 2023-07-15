import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safelane/Screens/RouteDetailsScreens/routeDetails.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';

class RouteBoxScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<AppCubit>().drawRouteCubit();

    return BlocProvider.value(
      value: context.watch<AppCubit>(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Container(
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                // Initial route is the routeDetailsScreen
                if (settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RouteDetailsScreen("10:24 PM"),
                  );
                }
                return null;
              },
            ),
          );
        },
      ),
    );
  }
}
