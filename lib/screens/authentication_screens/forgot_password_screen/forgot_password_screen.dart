import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../local_widgets/button_x.dart';
import '../local_widgets/text_field_x.dart';
import '../local_widgets/text_line_button.dart';
import '../sign_in_screen/sign_in_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();

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
                  Text('Forgot Password ? ',
                      style: Theme.of(context).textTheme.headline5),
                  Text(
                    "Don't worry! We will send you a password reset link to your email.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextFieldX(
                      label: 'Email',
                      //hintText: 'email',

                      icon: Icons.email,
                      controller: _emailController,
                      keybord: TextInputType.emailAddress),

/**/
                  ButtonX(
                      text: 'Send Password reset Email',
                      onTap: () {
                        Get.snackbar("Success", "PasswordReset Link");
                      }),
                  TextLineButton(
                      firstText: "Remember Password? ",
                      buttonText: 'Sign In Now',
                      onTap: () {
                        Get.to(SignInScreenView());
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
