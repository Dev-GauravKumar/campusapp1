import 'package:campusapp/LoginPage.dart';
import 'package:campusapp/userPreferences.dart';
import 'package:flutter/material.dart';

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? user = userPreferences.getUser();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('$user'.toUpperCase(),),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(title: Text('Logout'),onTap: (){
            userPreferences.setUser('');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage(),), (route) => false);
          },),
        ],
      ),
    );
  }
}
