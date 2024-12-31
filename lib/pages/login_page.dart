import 'package:flutter/material.dart';
import 'package:habittracker/components/my_account_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //email controller
    final emailTextController = TextEditingController();

    //password controller
    final passwordTextController = TextEditingController();

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            //Logo icons
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Icon(
                Icons.lock,
                size: 100,
              ),
            ),

            SizedBox(height: 50),
            //welcome text
            Text('Welcome back you have been missed!',
                style: TextStyle(
                  fontSize: 14,
                )),

            SizedBox(height: 25),

            //email field
            MyAccountTextField(
              controller: emailTextController,
              hintText: 'Username',
              obscureText: false,
            ),
            SizedBox(height: 10),
            //password field
            MyAccountTextField(
              controller: passwordTextController,
              hintText: 'Password',
              obscureText: true,
            ),

            SizedBox(
              height: 10,
            ),
            
            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?'),
                ],
              ),
            ),
            //signin button
            //continue with
            //google and apple authentication
          ],
        ),
      ),
    ));
  }
}
