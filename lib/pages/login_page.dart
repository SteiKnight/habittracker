import 'package:flutter/material.dart';
import 'package:habittracker/components/external_log_panel.dart';
import 'package:habittracker/components/my_account_text_field.dart';
import 'package:habittracker/components/my_log_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  //sign in function
  void signIn() {
    
  }

  @override
  Widget build(BuildContext context) {
    //email controller
    final emailTextController = TextEditingController();

    //password controller
    final passwordTextController = TextEditingController();

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(height: 50),
              //welcome text
              Text(
                'Welcome back you have been missed!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

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
              SizedBox(height: 25),
              //signin button
              MyLogButton(text: 'Sign In', onTap: signIn),

              SizedBox(height: 25),

              //continue with
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //google and apple authentication
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExternalLogPanel(
                    imagePath: 'lib/images/google.png',
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ExternalLogPanel(
                    imagePath: 'lib/images/apple.png',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(width: 4),
                  Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
