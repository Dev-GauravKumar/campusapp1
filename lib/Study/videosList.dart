import 'package:campusapp/Study/videoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class videosList extends StatefulWidget {
  final String collection;
  const videosList({required this.collection});

  @override
  State<videosList> createState() => _videosListState();
}

class _videosListState extends State<videosList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collection),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<List<video>>(stream:readData(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('Something Went Wrong! ${snapshot.error}');
            }else if(snapshot.hasData){
              final video=snapshot.data;
              return ListView(
                scrollDirection: Axis.vertical,
                children: video!.map(buildList).toList(),
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
  Widget buildList(video video){
    return Container(
      color: Colors.lightBlueAccent,
      child: Text('${video.link}'),
    );

  }
  Stream<List<video>> readData() => FirebaseFirestore.instance
      .collection(widget.collection)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => video.fromJson(doc.data())).toList());
 }
