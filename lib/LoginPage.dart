import 'package:campusapp/LoginForm.dart';
import 'package:campusapp/userPreferences.dart';
import 'package:flutter/material.dart';
import 'Student/HomePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 250, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Hello\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Welcome To Campus\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                        radius: 50,
                      ),
                      onTap: () {
                        userPreferences.setUser('student');
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(),), (route) => false);
                      }
                    ),
                    const Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                        radius: 50,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginForm(),
                          ),
                        );
                      }
                    ),
                    const Text(
                      'Staff',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
