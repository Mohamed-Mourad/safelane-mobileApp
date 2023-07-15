import 'package:flutter/material.dart';
import 'package:safelane/Shared/components/constants.dart';

class CustomMapButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const CustomMapButton({Key? key, required this.onPressed, required this.icon, this.top, this.left, this.right, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 40.0,
        height: 40.0,
        child: FloatingActionButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          backgroundColor: base,
          child: Icon(icon, color: SLNavy, size: 24.0),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final Color? textColor;

  const DialogButton({Key? key, required this.text, required this.onPressed, required this.buttonColor ,this.textColor});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text, 
        style: TextStyle(
          fontFamily:"Poppins", 
          color: textColor
        )
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        minimumSize: Size(220.0, 45.0),
        backgroundColor: MaterialStateColor.resolveWith((states) => buttonColor)
      ),
    );
  }
}