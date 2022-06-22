import 'package:campusapp/Study/Books/bookSection.dart';
import 'package:campusapp/Study/Notes/notesSection.dart';
import 'package:campusapp/Study/Questions%20Papers/qPaperSection.dart';
import 'package:campusapp/Study/Videos/videoSection.dart';
import 'package:flutter/material.dart';
class studyHome extends StatelessWidget {
  const studyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children:[
        Text('Study',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Padding(
        padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: GridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const bookSection(),),),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: Image.asset('assets/Images/book.png',fit: BoxFit.contain,),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Books',style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const videoSection(),),),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: const Icon(Icons.video_library,color: Colors.black,size: 100,),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Videos',style: TextStyle(fontSize: 22),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const qPaperSection(),),),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: const Icon(Icons.sticky_note_2_sharp,color: Colors.black,size: 100,),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Questions Papers',style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const notesSection(),),),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: const Icon(Icons.note_alt,color: Colors.black,size: 100,),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Notes',style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
            ),
          ],
        ),
            ),
            ],
    );
  }
}
