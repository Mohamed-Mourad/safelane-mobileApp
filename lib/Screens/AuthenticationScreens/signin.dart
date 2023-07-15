import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:safelane/Shared/network/outbound.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Shared/components/asbDialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:safelane/Screens/AuthenticationScreens/widgetReuse.dart';
import 'package:safelane/Screens/AuthenticationScreens/formsValidation.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  bool passwordToggle = true;

  void signIn(String email, String password) async {
    String response = await OutboudRequests.requestSignIn(context, email, password);
 
    if(response == "\"SUCCESS\"")
      Navigator.pushNamed(context, '/map');
    else if(response == "\"INVALID_CREDENTIALS\"")
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ASBDialog().showSnackBar(context, "Ooops", "Invalid credentials provided. Try Again", MadosRed, ContentType.failure);
      });
    }
    else if(response == "\"INVALID_ACCOUNT_TYPE\"")
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ASBDialog().showSnackBar(context, "Looks like you're lost", "Government representatives can access SafeLane only through the website", MadosRed, ContentType.help);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                
                SizedBox(height: 130.0),
                Text(
                  'Welcome Back,'.toUpperCase(),
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 32,
                    color: SLNavy,
                    letterSpacing: 3,
                    fontFamily: "Sangu",
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Text(
                  'Let’s have a safe ride !',
                  style: TextStyle(
                    height: 1.5,
                    color: black,
                    fontSize: 20.0,
                    fontFamily: "Poppins",
                  ),
                ),
                  
                SizedBox(height: 30.0),
                DefaultTextField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  validator:(providedEmail) {return FormValidators.validateEmail(providedEmail!);},
                  isPasswordField: false,
                  passwordToggle: passwordToggle,
                ),

                SizedBox(height: 16.0),
                DefaultTextField(
                  controller: passwordController, 
                  hintText: 'Password', 
                  prefixIcon: Icons.password, 
                  validator: (providedPassword) {return FormValidators.validatePassword(providedPassword!, passwordController);}, 
                  isPasswordField: true,
                  passwordToggle: passwordToggle
                ),

                SizedBox(height: 40.0),
                AuthenticationButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    if(_formField.currentState!.validate())
                      signIn(emailController.text.toString().trim(), passwordController.text.toString().trim());
                  },
                ),

                SizedBox(height: 60.0),
                AuthenticationRedirection(
                  fineText: "Don't have an account ? ",
                  redirection: "Sign Up",
                  recognizer: TapGestureRecognizer()..onTap = () {Navigator.pushNamed(context, '/signup');},
                ),
                  
                SocialMediaRow(),
              ],
            ),
          )
        ),
      ),
    );
  }
}