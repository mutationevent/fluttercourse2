import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  loginWithGoogle() async {
    print('loginWithGoogle');
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print('googleUser => $googleUser');
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential cred =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Let\'s create vour account',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Full name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                label: Text('Enter your full name'),
                filled: true,
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            OutlinedButton.icon(
              onPressed: () {
                loginWithGoogle();
              },
              label: Text('Google'),
              icon: Image.asset(
                'assets/logos_google-icon-2.png',
                height: 30,
              ),
              style: OutlinedButton.styleFrom(
                  fixedSize: Size(
                MediaQuery.of(context).size.width,
                50,
              )),
            )
          ],
        ),
      ),
    );
  }
}
