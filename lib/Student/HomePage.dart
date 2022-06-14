import 'package:campusapp/Student/studentEvent.dart';
import 'package:campusapp/Student/studentNotice.dart';
import 'package:campusapp/Student/studentScholarship.dart';
import 'package:flutter/material.dart';
import '../Study/studyHome.dart';
import '../menu.dart';
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
      drawer: menu(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        //leading: IconButton(
          //  onPressed: () => userPreferences.setUser(''),
           // icon: const Icon(
            //  Icons.menu,
             // size: 30,
            //)),
        title: const Text(
          "My Campus",
          style: TextStyle(
              fontSize: 25,
              fontFamily: "Lobster-Regular",
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: ()=>print('Notification Button Clicked!!'), icon: const Icon(Icons.notifications,size: 25,)),
          IconButton(
              onPressed: () => print('Search Button Clicked! '),
              icon: const Icon(
                Icons.search,
                size: 25,
              )),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: bottomBar(context),
    );
  }
  final pages=const [home(),studentEvent(),studentScholarship(),studyHome()];
  Widget bottomBar(context){
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.red),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events',backgroundColor: Colors.red),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Scholarship',backgroundColor: Colors.red),
        BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: 'Study',backgroundColor: Colors.red),
      ],
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
