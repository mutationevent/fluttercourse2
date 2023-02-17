import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageComplete extends StatefulWidget {
  const LoginPageComplete({Key? key}) : super(key: key);

  @override
  State<LoginPageComplete> createState() => _LoginPageCompleteState();
}

class _LoginPageCompleteState extends State<LoginPageComplete> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
            FieldComponent(
              label: 'Full name',
              hint: 'Enter your full name',
            ),
            SizedBox(
              height: 24,
            ),
            FieldComponent(
              label: 'Email',
              hint: 'Enter your email address',
            ),
            SizedBox(height: 24),
            FieldComponent(
              label: 'Password',
              hint: 'Enter vour password',
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                print('goto login page');
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('logged', true);
                context.go('/home');
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                elevation: 0,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Divider(height: 32),
            OutlinedButton.icon(
              onPressed: () async {
                UserCredential cred = await signInWithGoogle();
                print(cred);
              },
              icon: Image.asset(
                'assets/logos_google-icon-2.png',
                height: 20,
              ),
              label: Text(
                'Sign Up with Goodle',
                style: TextStyle(color: Colors.black),
              ),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50)),
            )
          ],
        ),
      ),
    );
  }
}

class FieldComponent extends StatelessWidget {
  String label;
  String hint;
  bool obscureText = false;

  FieldComponent(
      {required this.label, required this.hint, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            label: Text(hint),
            filled: true,
            labelStyle: TextStyle(
              fontSize: 18,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        )
      ],
    );
  }
}
