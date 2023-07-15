import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:safelane/Shared/components/constants.dart';

class ConfettiScreen extends StatefulWidget {
  @override
  _ConfettiScreenState createState() => _ConfettiScreenState();
}

class _ConfettiScreenState extends State<ConfettiScreen> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerTopCenter.play();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.1,
              gravity: 0.1,
              colors: const [
                ConfettiBlue,
                ConfettiGreen,
                SLNavy,
                SLGreen,
                white,
                base,
              ],
            ),
          ),
        ],
      ),
    );
  }
}