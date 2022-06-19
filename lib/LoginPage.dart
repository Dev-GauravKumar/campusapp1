import 'package:campusapp/LoginForm.dart';
import 'package:campusapp/Student/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:campusapp/userPreferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 500,
            child: Image.asset(
              'assets/Images/starterScreen.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200, left: 50),
            child: const Text(
              'Welcome to',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 250, left: 50),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'CAM',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'PU',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 285, left: 115),
            width: 40,
            height: 2,
            color: Colors.black,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  userPreferences.setUser('student');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 350, left: 60),
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    'assets/Images/studentIcon.png',
                    cacheHeight: 80,
                    cacheWidth: 80,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 50),
                child: Text(
                  'Student',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginForm(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 350, left: 220),
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    'assets/Images/staffIcon.png',
                    cacheHeight: 80,
                    cacheWidth: 80,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 220),
                child: Text(
                  'Staff',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

