import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safelane/Shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safelane/Screens/onboarding.dart';
import 'Screens/AuthenticationScreens/manageCredentials.dart';
import 'package:safelane/Screens/AuthenticationScreens/signin.dart';
import 'Shared/cubit/cubit.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserCredentialsProvider()),
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: MaterialApp(
        title: 'SafeLane',
        routes: Routes.routes,
        home: MyApp(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetSwitcher(),
    );
  }
}


class WidgetSwitcher extends StatefulWidget {
  @override
  _WidgetSwitcherState createState() => _WidgetSwitcherState();
}

class _WidgetSwitcherState extends State<WidgetSwitcher> {
  bool showStatefulWidget = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        showStatefulWidget = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: showStatefulWidget ? OnboardingScreen() : SignInScreen());
  }
}
