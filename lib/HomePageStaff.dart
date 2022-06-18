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
      drawer: Container(
          width: 250,
          child: menu()),
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
                tileColor: Colors.orange,
                leading: Icon(Icons.post_add),
                title: const Text('Notice'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNotice(),)),
              ),
              ListTile(
                tileColor: Colors.orange,
                leading: Icon(Icons.school),
                title: const Text('Scholarship'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addScholarship(),)),
              ),
              ListTile(
                tileColor: Colors.orange,
                leading: Icon(Icons.event),
                title: const Text('Event'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addEvent(),),),
              ),
              ListTile(
                leading: Icon(Icons.video_library,color: Colors.white,),
                tileColor: Colors.black,
                title: Text('Add Videos',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addVideos(),),),),
              ListTile(
                leading: Icon(Icons.book,color: Colors.white,),
                tileColor: Colors.black,
                title: Text('Add Books',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addBooks(),),),),
              ListTile(
                leading: Icon(Icons.note_add,color: Colors.white,),
                tileColor: Colors.black,
                title: Text('Add Questions Papers',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> addQuestionsPaper(),),),),
              ListTile(
                leading: Icon(Icons.note_alt,color: Colors.white,),
                tileColor: Colors.black,
                title: Text('Add Notes',style: TextStyle(color: Colors.white),),
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
