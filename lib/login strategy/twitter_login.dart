import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';

Future<UserCredential> signInWithTwitter() async {
  // Create a TwitterLogin instance
  final twitterLogin = TwitterLogin(
      apiKey: '6BX4bAV5aJboMAAzCuHePwqMw',
      apiSecretKey:'WiYxQXTQlUnSs1WphbDazePDF1s7qgjhjrgREovtpGmJizKNzc',
      redirectURI: 'https://login-demo-84bc1.firebaseapp.com/__/auth/handler'
  );

  // Trigger the sign-in flow
  final authResult = await twitterLogin.login();

  // Create a credential from the access token
  final twitterAuthCredential = TwitterAuthProvider.credential(
    accessToken: authResult.authToken!,
    secret: authResult.authTokenSecret!,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
}