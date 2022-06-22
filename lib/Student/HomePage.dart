import 'package:campusapp/Student/studentEvent.dart';
import 'package:campusapp/Student/studentNotice.dart';
import 'package:campusapp/Student/studentScholarship.dart';
import 'package:campusapp/Study/studyHome.dart';
import 'package:campusapp/menu.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          width: 250,
          child: const menu()),
      appBar: AppBar(
        leading: Builder(
            builder: (context) {
              return Container(
                  color: Colors.cyan,
                  child: IconButton(onPressed:  ()=>Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu,size: 25,color: Colors.black,)));
            }
        ),
        backgroundColor: Colors.white,
        title: RichText(text: const TextSpan(text: 'My',style:TextStyle(color: Colors.black,fontSize: 25),
          children:[
            TextSpan(text: ' CAM',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
            TextSpan(text: 'PU',style: TextStyle(color: Colors.cyan,fontSize: 25,fontWeight: FontWeight.bold)),
            TextSpan(text: 'S',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),

        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 25,
                color: Colors.black,
              )),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: bottomBar(context),
    );
  }
  final pages=const [home(),studentEvent(),studentScholarship(),studyHome()];
  Widget bottomBar(context){
    return CurvedNavigationBar(
      height: 50,
      items: [Icon(Icons.home,color: _selectedIndex==0?Colors.black:Colors.white,),
        Icon(Icons.event,color: _selectedIndex==1?Colors.black:Colors.white,),
        Icon(Icons.school,color: _selectedIndex==2?Colors.black:Colors.white,),
        Icon(Icons.book_sharp,color: _selectedIndex==3?Colors.black:Colors.white,),
      ],
      buttonBackgroundColor: Colors.cyan,
      backgroundColor: Colors.transparent,
      color: Colors.black,
      index: _selectedIndex,

      /*const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.cyan),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events',backgroundColor: Colors.cyan),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Scholarship',backgroundColor: Colors.cyan),
        BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: 'Study',backgroundColor: Colors.cyan),
      ],*/
      onTap: (index) => setState(() {
        _selectedIndex = index;
      }),
    );
  }
}
class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      Text('News',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: studentNotice(),
      ),
    ],);
  }
}
