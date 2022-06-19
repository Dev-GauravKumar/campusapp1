import 'package:campusapp/LoginPage.dart';
import 'package:campusapp/userPreferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? user = userPreferences.getUser();
    return Drawer(
      child: ListView(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )),
          Container(
            height: 150,
            width: 150,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: ClipOval(
                        child: Image.asset('$user'.toUpperCase()=='STAFF'?
                      'assets/Images/staff.jpg':'assets/Images/student.jpg',
                      fit: BoxFit.contain,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$user'.toUpperCase(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: '$user'.toUpperCase()=='STAFF'?const Color.fromRGBO(255, 214, 138, 0.2):const Color.fromRGBO(243, 246, 251,1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                  shadowColor: '$user'.toUpperCase()=='STAFF'?Colors.orange:Colors.cyan,
                  primary: '$user'.toUpperCase()=='STAFF'?Colors.orange:Colors.cyan, fixedSize: const Size(50, 40)),
              child: const Text('Logout'),
              onPressed: () {
                userPreferences.setUser('');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const RotatedBox(
                  quarterTurns: 3,
                  child: Text('F O L L O W  \t U S'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Link(
                          target: LinkTarget.defaultTarget,
                          uri:Uri.parse('https://www.facebook.com/PGGC11/'),
                          builder: (context, followLink) => GestureDetector(
                            onTap: followLink,
                            child: Container(
                                height: 25,
                                width: 25,
                                child: Image.asset('assets/Images/facebook.png')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Link(
                          target: LinkTarget.defaultTarget,
                          uri:Uri.parse('https://www.instagram.com/explore/tags/pggc11/?hl=en'),
                          builder: (context, followLink) => GestureDetector(
                            onTap: followLink,
                            child: Container(
                                height: 25,
                                width: 25,
                                child: Image.asset('assets/Images/insta.png')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Link(
                          target: LinkTarget.defaultTarget,
                          uri:Uri.parse('https://www.youtube.com/c/C4KNOWLEDGESEEKERS/featured'),
                          builder: (context, followLink) =>GestureDetector(
                            onTap: followLink,
                            child: Container(
                                height: 25,
                                width: 25,
                                child: Image.asset('assets/Images/youtube.png')),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
