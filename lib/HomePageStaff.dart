import 'package:campusapp/Event/addEvent.dart';
import 'package:campusapp/Event/event.dart';
import 'package:campusapp/Post/AddNotice.dart';
import 'package:campusapp/Post/Notice.dart';
import 'package:campusapp/Scholarship/addScholarship.dart';
import 'package:campusapp/Scholarship/scholarship.dart';
import 'package:campusapp/Study/Notes/addNotes.dart';
import 'package:campusapp/Study/Questions%20Papers/addQuestionsPaper.dart';
import 'package:campusapp/Study/studyHome.dart';
import 'package:campusapp/menu.dart';
import 'package:flutter/material.dart';
import 'package:campusapp/Study/Videos/addVideos.dart';

import 'Study/Books/addBooks.dart';
class HomePageStaff extends StatefulWidget {
  const HomePageStaff({Key? key}) : super(key: key);

  @override
  State<HomePageStaff> createState() => _HomePageStaffState();
}

class _HomePageStaffState extends State<HomePageStaff> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: menu(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return Container(
                color: Colors.orange,
                child: IconButton(onPressed:  ()=>Scaffold.of(context).openDrawer(), icon: Icon(Icons.menu,size: 25,color: Colors.black,)));
          }
        ),
        backgroundColor: Colors.white,
        title: RichText(text: TextSpan(text: 'My',style:TextStyle(color: Colors.black,fontSize: 25),
        children:[
         TextSpan(text: ' CAM',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
          TextSpan(text: 'PU',style: TextStyle(color: Colors.orange,fontSize: 25,fontWeight: FontWeight.bold)),
          TextSpan(text: 'S',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
        ],
        ),
          
        ),
        actions: [
          IconButton(onPressed: ()=>print('Notification Button Clicked!!'), icon: const Icon(Icons.notifications,size: 25,color: Colors.black,)),
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>thumbnail('https://www.youtube.com/watch?v=GQyWIur03aw'))),
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
  final pages=const [home(),Event(),home(),scholarship(),studyHome()];
  Widget bottomBar(context){
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Scholarship',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: 'Study',backgroundColor: Colors.orange),
      ],
      onTap: (index) => index == 2
          ? showModalBottomSheet(
          context: context,
          builder: (context) => ListView(
            children: [
              ListTile(
                title: const Text('Notice'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNotice(),)),
              ),
              ListTile(
                title: const Text('Scholarship'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addScholarship(),)),
              ),
              ListTile(
                title: const Text('Event'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addEvent(),),),
              ),
              ListTile(
                title: Text('Add Videos'),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addVideos(),),),),
              ListTile(
                title: Text('Add Books'),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addBooks(),),),),
              ListTile(
                title: Text('Add Questions Papers'),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addQuestionsPaper(),),),),
              ListTile(
                title: Text('Add Notes'),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addNotes(),),),),
            ],
          ))
          : setState(() {
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
        child: Notice(),
      ),
    ],);
  }
}
class thumbnail extends StatelessWidget {
  String url;
  thumbnail(this.url);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>id('https://www.youtube.com/watch?v=y7MW7d8fb1Y')??Container()));}, child: Text('Get Thumbnail')),

    );
  }
  Widget? id(String url){
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    return Container(child: Image.network('https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg'),);
  }
}
