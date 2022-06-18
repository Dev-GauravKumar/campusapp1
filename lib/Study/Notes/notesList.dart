import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../Videos/videoModel.dart';
class notesList extends StatefulWidget {
  final String collection;
  notesList({required this.collection});

  @override
  State<notesList> createState() => _notesListState();
}

class _notesListState extends State<notesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collection),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<List<video>>(stream:readData(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('Something Went Wrong! ${snapshot.error}');
            }else if(snapshot.hasData){
              final Notes=snapshot.data;
              return ListView(
                scrollDirection: Axis.vertical,
                children: Notes!.map(buildList).toList(),
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
  Widget buildList(video Notes){
    return Card(
      child: Link(
        target: LinkTarget.defaultTarget,
        uri:Uri.parse('${Notes.link}'),
        builder: (context, followLink) => GestureDetector(
          onTap: followLink,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red
                      ),
                      height: 100,
                      width: 120,
                      child: Icon(Icons.picture_as_pdf,size: 100,color: Colors.white,),
                    ),
                    SizedBox(width: 30.0,),
                    Container(width: 1,height: 100,color: Colors.black26,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('${Notes.title}',style: TextStyle(fontSize: 20,color: Colors.black),)),
                  ],
                )
            ),
          ),
        ),
      ),
    );}
  Stream<List<video>> readData() => FirebaseFirestore.instance
      .collection('${widget.collection} Notes')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => video.fromJson(doc.data())).toList());
}



