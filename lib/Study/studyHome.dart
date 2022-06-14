import 'package:campusapp/Study/videoSection.dart';
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
            child: Card(
              color: Colors.red,
              child: Column(
                children: [
                  Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 150,
                  ),
                  Text('Books',style: TextStyle(fontSize: 30,color: Colors.white),),
                ],
              ),
              elevation: 20,
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
                      Icons.perm_media,
                      color: Colors.white,
                      size: 150,
                    ),
                    Text('Videos',style: TextStyle(fontSize: 30,color: Colors.white),),
                    ]),),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>videoSection(),),),
            ),
          ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1.5,
                    child: Card(
                      color: Colors.red,
                      child: Column(
                        children: [
                          Icon(
                            Icons.newspaper,
                            color: Colors.white,
                            size: 150,
                          ),
                          Text('Question Papers',style: TextStyle(fontSize: 30,color: Colors.white),),
  ],),),),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: Card(
                              color: Colors.red,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.request_page_rounded,
                                    color: Colors.white,
                                    size: 150,
                                  ),
                                  Text('Practice',style: TextStyle(fontSize: 30,color: Colors.white),),
                                ],
                              ),
                              elevation: 20,
                            ),
                          ),
                        ],
        mainAxisSpacing: 50,
        crossAxisSpacing: 50,
                      ),
    );
  }
}
