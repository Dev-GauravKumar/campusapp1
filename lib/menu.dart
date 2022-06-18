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
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close),)),
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
                  child:
                  ClipOval(child: Image.asset('assets/profile.jpg',fit: BoxFit.contain,)),
                ),
              ) ,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${user}'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),
              ],
    ),
            decoration: BoxDecoration(
              color: Color.fromRGBO( 255, 214, 138,0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange,fixedSize: Size(50, 40)),
              child: Text('Logout'),onPressed: (){
              userPreferences.setUser('');
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage(),), (route) => false);
            },),
          )

        ],
      ),
    );
  }
}
