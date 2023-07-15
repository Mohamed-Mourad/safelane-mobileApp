import 'dart:ui';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: base,
      body: Stack(
        children:[
          Positioned(
            width: MediaQuery.of(context).size.width,
            left: 200,
            top: 0,
            child: Image.asset("assets/RiveAssets/filledBB.png"),
          ),
          
          Positioned.fill(
            child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10)),
          ),
          const RiveAnimation.asset("assets/RiveAssets/backgroundWhite.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          
          AnimatedPositioned(
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only (top: 180, left: 20, right: 20),
                child: Column(
                  children:[
                    SizedBox(
                      child: Column(
                        children: const[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Navigating",
                              style: TextStyle(
                                fontSize: 55,
                                fontFamily: "Sangu",
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                                letterSpacing: 4,
                                color: SLNavy,
                              ),
                            ),
                          ),

                          Align
                          (
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Safer Roads",
                              style: TextStyle(
                                fontSize: 52,
                                fontFamily: "Sangu",
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                height: 2,
                                color: SLNavy,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child:Text(
                              "Together",
                              style: TextStyle(
                                fontSize: 86,
                                fontFamily: "HonestSky",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 3.0,
                                height: 1.7,
                                color: SLGreen,
                              ),
                            ),
                          ),
                          
                          Icon(
                            FontAwesome.smile_o,
                            size: 20.0,
                            color: SLNavy,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}