import 'package:flutter/material.dart';

class NotVerifiedDoctorScreen extends StatelessWidget {
  const NotVerifiedDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Doctor is not verified. Please submit your documents to praveen2too@gmail.com'),

          ],
        ),
      ),
    );
  }
}
