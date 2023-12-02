// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oauth2login/login%20strategy/facebook_login.dart';
import 'package:oauth2login/login%20strategy/google_login.dart';
import 'package:oauth2login/login%20strategy/twitter_login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Social Login Demo',
      home: SocialLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text("Login via:", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.blue),),
              SocialLoginButton(
                icon: FontAwesomeIcons.google,
                text: 'Google',
                onPressed: () async {
                  UserCredential userCredential = await signInWithGoogle();
                  print(userCredential);
                  if(userCredential!= null) {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Google User Credentials'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('User ID: ${userCredential.user?.uid}'),
                            Text('Display Name: ${userCredential.user?.displayName}'),
                            Text('Email: ${userCredential.user?.email}'),
                            // Add more user information as needed
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }
                },
                color: Colors.green
              ),
              SocialLoginButton(
                icon: Icons.facebook,
                text: 'Facebook',
                onPressed: () async {
                  UserCredential userCredential = await signInWithFacebook();
                  if(userCredential!= null) {
                    showDialog(context: context, builder: (context){
                      print(userCredential.user);
                      return AlertDialog(
                        title: const Text('Facebook User Credentials'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('User ID: ${userCredential.user?.uid}'),
                            Text('Display Name: ${userCredential.user?.displayName}'),
                            Text('Email: ${userCredential.user?.providerData}'),
                            // Add more user information as needed
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }
                },
                color: Colors.blueAccent,
              ),
              SocialLoginButton(
                icon: FontAwesomeIcons.twitter,
                text: 'Twitter',
                onPressed: () async {
                  UserCredential userCredential = await signInWithTwitter() ;
                  if(userCredential!= null) {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Twitter User Credentials'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('User ID: ${userCredential.user?.uid}'),
                            Text('Display Name: ${userCredential.user?.displayName}'),
                            Text('Email: ${userCredential.user?.email}'),
                            // Add more user information as needed
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }
                },
                color: Colors.cyan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const SocialLoginButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: color),
    );
  }
}
