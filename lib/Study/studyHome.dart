import 'package:campusapp/Study/Books/bookSection.dart';
import 'package:campusapp/Study/Notes/notesSection.dart';
import 'package:campusapp/Study/Questions%20Papers/qPaperSection.dart';
import 'package:campusapp/Study/Videos/videoSection.dart';
import 'package:flutter/material.dart';

class studyHome extends StatelessWidget {
  const studyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: GridView.count(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>bookSection(),),),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: Image.asset('assets/book.png',fit: BoxFit.contain,),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Books',style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>videoSection(),),),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: Icon(Icons.video_library,size: 100,),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Videos',style: TextStyle(fontSize: 22),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>qPaperSection(),),),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: Icon(Icons.sticky_note_2_sharp,size: 100,),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Questions Papers',style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>notesSection(),),),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: Icon(Icons.note_alt,size: 100,),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Notes',style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
