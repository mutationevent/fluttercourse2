import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttercourceecommerce2/pages/LoginPage.dart';
import 'package:fluttercourceecommerce2/pages/LoginPageComplete.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    verifUser();
  }

  verifUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool? islogged = prefs.getBool('logged');
    if (islogged != null) {
      if (islogged) {
        GoRouter.of(context).go('/home');
      }
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/Onboarding.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                print('login');
                context.go('/login');
                //GoRouter.of(context).go('/login');
                //GoRouter.of(context).go('article/${blog.id}');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return new LoginPageComplete();
                //     },
                //   ),
                // );
              },
              child: Container(
                //color: Colors.black,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
