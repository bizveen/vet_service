import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_gate.dart';
import '../../../models/User_model.dart';
import '../../../models/client_model.dart';
import '../../../resources/firebase_database_methods.dart';
import '../local_widgets/button_x.dart';
import '../local_widgets/text_field_x.dart';
import '../local_widgets/text_line_button.dart';
import '../sign_in_screen/sign_in_screen.dart';



class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//FirebaseAuthController authController = Get.put(FirebaseAuthController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();

  String? role = 'Doctor';

  @override
  void dispose() {
   emailController.dispose();
   passwordController.dispose();
   nameController.dispose();
   verifyPasswordController.dispose();
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    verifyPasswordController.dispose();
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
                  Text('Sign Up Now',
                      style: Theme.of(context).textTheme.headline5),
                  TextFieldX(
                      label: 'Full Name',
                      //hintText: 'email',

                      icon: Icons.email,
                      controller: nameController,
                      keybord: TextInputType.emailAddress),
                  TextFieldX(
                      label: 'Email',
                      //hintText: 'email',

                      icon: Icons.email,
                      controller: emailController,
                      keybord: TextInputType.emailAddress),
                  TextFieldX(
                      // hintText: 'Password',
                      label: 'Password',
                      icon: Icons.lock,
                      controller: passwordController,
                      keybord: TextInputType.emailAddress),
                  TextFieldX(
                      // hintText: 'Password',
                      label: 'Verify Password',
                      icon: Icons.lock,
                      controller: verifyPasswordController,
                      keybord: TextInputType.emailAddress),
                  DropdownButton<String>(
                    value: role,
                    items: <String>['Doctor', 'Assistant', 'Nurse', 'Other']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                  ButtonX(
                      text: 'Sign Up',
                      onTap: () async{
                       await FirebaseAuth.instance.createUserWithEmailAndPassword(
                           email: emailController.text.trim(), password: passwordController.text.trim());
UserModel user = UserModel(
  id:  FirebaseAuth.instance.currentUser!.uid,

);
FirebaseDatabaseMethods().updateBatch({'users/${user.id}': user.toJson()});
                        Get.to(AuthGate());
                      }),
                  TextLineButton(
                      firstText: "Have an account? ",
                      buttonText: 'Sign In Here',
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
