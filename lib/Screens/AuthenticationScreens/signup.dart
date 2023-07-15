import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:safelane/Shared/network/outbound.dart';
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Shared/components/asbDialog.dart';
import 'package:safelane/Screens/AuthenticationScreens/confetti.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:safelane/Screens/AuthenticationScreens/widgetReuse.dart';
import 'package:safelane/Screens/AuthenticationScreens/formsValidation.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> 
{
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPController = TextEditingController();
  final usernameController = TextEditingController();
  
  bool passwordToggle = true;
  bool confirmPasswordToggle = true;

  bool celebrate = false;

  void signUp(String username, String email, String password) async {
    bool response = await OutboudRequests.requestSignUp(username, email, password);
   
    if (response) {
      setState(() {celebrate = true;});
      await Future.delayed(const Duration(seconds: 3));
      setState(() {celebrate = false;});

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ASBDialog().showSnackBar(context, "Welcome onboard !", "Log in and start your journey right away", Colors.red, ContentType.success);
      });
      Navigator.pushNamed(context, '/signin');
    }
    else
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ASBDialog().showSnackBar(context, "Email already registered", "Please register with a new email or sign in !", Colors.red, ContentType.warning);
      });
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: base,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.0,
            right: 20.0,
          ),
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[

                if (celebrate)
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiScreen(),
                ),

                SizedBox(height: 70.0),
                Text(
                  'Let\'s Get Started!,'.toUpperCase(),
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 30,
                    color: SLNavy,
                    letterSpacing: 3,
                    fontFamily: "Sangu",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  
                Text(
                  'Create your profile and start your journey',
                  style: TextStyle(
                    height: 1.5,
                    color: black,
                    fontSize: 15.0,
                    fontFamily: "Poppins",
                  ),
                ),

                SizedBox(height: 30.0),
                DefaultTextField(
                  controller: usernameController,
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                  validator:(providedUsername) {return FormValidators.validateUsername(providedUsername!);},
                  isPasswordField: false,
                  passwordToggle: passwordToggle,
                ),

                SizedBox(height: 16.0),
                DefaultTextField
                (
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
              
                SizedBox(height: 16.0),
                DefaultTextField(
                  controller: confirmPController, 
                  hintText: 'Confirm Password', 
                  prefixIcon: Icons.password, 
                  validator: (confirmPassword) {return FormValidators.validateMatchingPwds(confirmPController, passwordController);},
                  isPasswordField: true,
                  passwordToggle: confirmPasswordToggle
                ),

                SizedBox(height: 24.0),
                AuthenticationButton(
                  buttonText: "Sign Up",
                  onPressed: () {
                    if(_formField.currentState!.validate())
                        signUp(usernameController.text.toString().trim(), emailController.text.toString().trim(), passwordController.text.toString().trim());
                  },
                ),
                
                SizedBox(height: 20.0),
                AuthenticationRedirection(
                  fineText: "Already Have An Account ? ",
                  redirection: "Sign In",
                  recognizer: TapGestureRecognizer()..onTap = () {Navigator.pushNamed(context, '/signin');},
                ),
                 
                SocialMediaRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}