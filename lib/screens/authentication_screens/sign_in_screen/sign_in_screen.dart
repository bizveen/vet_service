import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_gate.dart';
import '../forgot_password_screen/forgot_password_screen.dart';
import '../local_widgets/button_x.dart';
import '../local_widgets/text_field_x.dart';
import '../local_widgets/text_line_button.dart';
import '../sign_up_screen/sign_up_screen.dart';



class SignInScreenView extends StatefulWidget {
  SignInScreenView({Key? key}) : super(key: key);

  @override
  State<SignInScreenView> createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreenView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign In here',
                      style: Theme.of(context).textTheme.headline5),
                  TextFieldX(
                      label: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                      keybord: TextInputType.emailAddress),
                  TextLineButton(
                      firstText: '',
                      buttonText: 'Forgot Password?',
                      alignmentRight: true,
                      onTap: () {
                        Get.to(ForgotPasswordScreen());
                      }),
                  TextFieldX(
                      // hintText: 'Password',
                      label: 'Password',
                      icon: Icons.lock,
                      controller: passwordController,
                      keybord: TextInputType.emailAddress),
/**/
                  ButtonX(
                      text: 'Sign In',
                      onTap: () async{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());

                        Get.snackbar("Success", "Signed in");

                        Get.to(AuthGate());
                      }),
                  TextLineButton(
                      firstText: "Still don't have an account? ",
                      buttonText: 'Sign Up Now',
                      onTap: () {
                        Get.to(SignUpScreen());
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
