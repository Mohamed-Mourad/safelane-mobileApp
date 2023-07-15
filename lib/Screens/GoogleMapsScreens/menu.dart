import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Screens/GoogleMapsScreens/widgetReuse.dart';
import 'package:safelane/Screens/AuthenticationScreens/manageCredentials.dart';
import 'package:safelane/Shared/network/outbound.dart';

class CustomMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userCredentialsProvider = Provider.of<UserCredentialsProvider>(context);
    final UserCredentials? userCredentials = userCredentialsProvider.userCredentials;

    final String? username = userCredentials?.username;
    final String? email = userCredentials?.email;
    final String? password = userCredentials?.password;

    return CustomMapButton(
    top: 30, 
    left: 15,
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                    Container(
                      padding: EdgeInsets.only(top:10.0),
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/Images/wave.png'),
                    ),
                              
                    SizedBox(height: 10),
                    Text('See You On The Next Trip, $username!', style: TextStyle(fontFamily:"Poppins")),
                              
                    SizedBox(height: 20),
                    DialogButton(text: 'Stay', onPressed: (){Navigator.of(context).pop(false);}, buttonColor: base, textColor: black),
                              
                    SizedBox(height: 10),
                    DialogButton(
                      text: 'Sign Out', 
                      onPressed: () {
                        Navigator.pushNamed(context, "/signin");
                        OutboudRequests.requestSignOut(email ?? '', password ?? '');
                      }, 
                      buttonColor: MadosRed
                    ),
                            
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: Icons.logout,
    );
  }
}