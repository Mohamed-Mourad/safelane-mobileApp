import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  bool passwordToggle;
 
  DefaultTextField({super.key, required this.controller,required this.hintText, required this.prefixIcon, required this.validator, required this.isPasswordField, required this.passwordToggle});

  @override
  _DefaultTextFieldState createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? widget.passwordToggle : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon, color: SLNavy, size: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SLGreen),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        
        labelStyle: TextStyle(
          color: SLNavy,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        
        suffix: widget.isPasswordField ? 
          InkWell(
            onTap: (){setState(() {widget.passwordToggle = !widget.passwordToggle;});},
            child: Icon(widget.passwordToggle ? Icons.visibility_off : Icons.visibility, size: 20),
          )
          : null,
      ),
      validator: widget.validator,
    );
  }
}

class AuthenticationButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthenticationButton({super.key, required this.buttonText, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      key: Key(buttonText),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SLGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),

        child: Text(
          buttonText.toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            color: SLNavy,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}

class AuthenticationRedirection extends StatelessWidget {
  final String fineText;
  final String redirection;
  final GestureRecognizer recognizer;

  const AuthenticationRedirection({super.key, required this.fineText, required this.redirection, required this.recognizer});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: fineText,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Poppins",
            color: black,
          ),

          children:[
            TextSpan(
              text: redirection,
              style: TextStyle(
                color: SLNavy,
                fontSize: 16.0,
                fontFamily: "Poppins",
              ),
              recognizer: recognizer,
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        IconButton(onPressed: () {}, icon: Icon(FontAwesome.instagram, color: SLNavy, size: 20)),
        IconButton(onPressed: () {}, icon: Icon(FontAwesome.twitter, color: SLNavy,  size: 20)),
        IconButton(onPressed: () {}, icon: Icon(FontAwesome.facebook, color: SLNavy,  size: 20)),
      ],
    );
  }
}