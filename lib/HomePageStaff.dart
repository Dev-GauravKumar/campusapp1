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
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      drawerEnableOpenDragGesture: true,
      extendBody: true,
      drawer: Container(
          width: 250,
          child: const menu()),
      body: NestedScrollView(
        headerSliverBuilder:(context,innerBoxIsSCrolled)=> [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.cyan,),
            ),
            leadingWidth: 100,
            leading: Builder(
                builder: (context) {
                  return Container(
                      color: Colors.cyan,
                      child: IconButton(onPressed:  ()=>Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu,size: 25,color: Colors.black,)));
                }
            ),
            backgroundColor: Colors.white,
            title: RichText(text: const TextSpan(text: 'My   ___',style:TextStyle(color: Colors.black,fontSize: 25),
              children:[
                TextSpan(text: '\nCAM',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
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
          ),],
        body: pages[_selectedIndex],
      ),
      bottomNavigationBar: bottomBar(context),
    );
  }
  final pages=const [home(),Event(),home(),scholarship(),studyHome()];
  Widget bottomBar(context){
    return CurvedNavigationBar(
      height: 50,
      items: [Icon(Icons.home,color: _selectedIndex==0?Colors.black:Colors.white,),
        Icon(Icons.event,color: _selectedIndex==1?Colors.black:Colors.white,),
        Icon(Icons.add,color: _selectedIndex==2?Colors.black:Colors.white,),
        Icon(Icons.school,color: _selectedIndex==3?Colors.black:Colors.white,),
        Icon(Icons.book_sharp,color: _selectedIndex==4?Colors.black:Colors.white,),
      ],
      buttonBackgroundColor: Colors.orange,
      backgroundColor: Colors.transparent,
      color: Colors.black,
      index: _selectedIndex,

     /*item: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Scholarship',backgroundColor: Colors.orange),
        BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: 'Study',backgroundColor: Colors.orange),
      ],*/
      onTap: (index) => index == 2
          ? showModalBottomSheet(
          context: context,
          builder: (context) => ListView(

            children: [
              const SizedBox(height: 5,),
              ListTile(
                tileColor: Colors.orange,
                leading: const Icon(Icons.post_add,color: Colors.black,),
                trailing: const Icon(Icons.add,color: Colors.black,),
                title: const Text('Notice'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNotice(),)),
              ),
              const SizedBox(height: 5,),
              ListTile(
                tileColor: Colors.orange,
                leading: const Icon(Icons.school,color: Colors.black,),
                trailing: const Icon(Icons.add,color: Colors.black,),
                title: const Text('Scholarship'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addScholarship(),)),
              ),
              const SizedBox(height: 5,),
              ListTile(
                tileColor: Colors.orange,
                leading: const Icon(Icons.event,color: Colors.black,),
                trailing: const Icon(Icons.add,color: Colors.black,),
                title: const Text('Event'),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const addEvent(),),),
              ),
              const SizedBox(height: 30,),
              ListTile(
                leading: const Icon(Icons.video_library,color: Colors.white,),
                tileColor: Colors.black,
                trailing: const Icon(Icons.add,color: Colors.white,),
                title: const Text('Add Videos',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const addVideos(),),),),
              const SizedBox(height: 5,),
              ListTile(
                leading: const Icon(Icons.book,color: Colors.white,),
                tileColor: Colors.black,
                trailing: const Icon(Icons.add,color: Colors.white,),
                title: const Text('Add Books',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const addBooks(),),),),
              const SizedBox(height: 5,),
              ListTile(
                leading: const Icon(Icons.note_add,color: Colors.white,),
                tileColor: Colors.black,
                trailing: const Icon(Icons.add,color: Colors.white,),
                title: const Text('Add Questions Papers',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const addQuestionsPaper(),),),),
              const SizedBox(height: 5,),
              ListTile(
                leading: const Icon(Icons.note_alt,color: Colors.white,),
                tileColor: Colors.black,
                trailing: const Icon(Icons.add,color: Colors.white,),
                title: const Text('Add Notes',style: TextStyle(color: Colors.white),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const addNotes(),),),),
              const SizedBox(height: 5,),
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
