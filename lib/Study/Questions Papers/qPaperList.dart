import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../Videos/videoModel.dart';
class qPaperList extends StatefulWidget {
  final String collection;
  qPaperList({required this.collection});

  @override
  State<qPaperList> createState() => _qPaperListState();
}

class _qPaperListState extends State<qPaperList> {
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
              final QP=snapshot.data;
              return ListView(
                scrollDirection: Axis.vertical,
                children: QP!.map(buildList).toList(),
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
  Widget buildList(video QP){
    return Container(
      child: Link(
        target: LinkTarget.defaultTarget,
        uri:Uri.parse('${QP.link}'),
        builder: (context, followLink) => GestureDetector(
          onTap: followLink,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Row(
                  children: [
                    Container(
                      color: Colors.red,
                      height: 100,
                      width: 120,
                      child: Icon(Icons.picture_as_pdf,size: 100,color: Colors.white,),
                    ),
                    SizedBox(width: 40.0,),
                    Expanded(child: Text('${QP.title}',style: TextStyle(fontSize: 20,color: Colors.black),)),
                  ],
                )
            ),
          ),
        ),
      ),
    );}
  Stream<List<video>> readData() => FirebaseFirestore.instance
      .collection('${widget.collection} QP')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => video.fromJson(doc.data())).toList());
}



