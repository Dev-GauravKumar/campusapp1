import 'package:campusapp/Study/Books/bookSection.dart';
import 'package:campusapp/Study/Notes/notesSection.dart';
import 'package:campusapp/Study/Questions%20Papers/qPaperSection.dart';
import 'package:campusapp/Study/Videos/videoSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class studyHome extends StatelessWidget {
  const studyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.5,
            child: GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>bookSection(),),),
              child: Card(
                color: Colors.red,
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_stories,
                      color: Colors.white,
                      size: 150,
                    ),
                    SizedBox(height: 20,),
                    Text('Books',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ],
                ),
                elevation: 20,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.5,
            child: GestureDetector(
              child: Card(
                color: Colors.red,
                child: Column(
                  children: [
                    Icon(
                      Icons.video_library,
                      color: Colors.white,
                      size: 150,
                    ),
                    SizedBox(height: 20,),
                    Text('Videos',style: TextStyle(fontSize: 30,color: Colors.white),),
                    ]),),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>videoSection(),),),
            ),
          ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1.5,
                    child: GestureDetector(
                      child: Card(
                        color: Colors.red,
                        child: Column(
                          children: [
                            Icon(
                              Icons.feed,
                              color: Colors.white,
                              size: 150,
                            ),
                            SizedBox(height: 20,),
                            Text('Questions Papers',style: TextStyle(fontSize: 30,color: Colors.white),),
  ],),),
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>qPaperSection(),),),
                    ),
                  ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: GestureDetector(
                              child: Card(
                                color: Colors.red,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.note_alt,
                                      color: Colors.white,
                                      size: 150,
                                    ),
                                    SizedBox(height: 20,),
                                    Text('Notes',style: TextStyle(fontSize: 30,color: Colors.white),),
                                  ],
                                ),
                                elevation: 20,
                              ),
                              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>notesSection(),),),
                            ),
                          ),
                        ],
        mainAxisSpacing: 50,
        crossAxisSpacing: 50,
                      ),
    );
  }
}
