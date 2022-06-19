import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../Videos/videoModel.dart';
import 'package:campusapp/userPreferences.dart';
class booksList extends StatefulWidget {
  final String collection;
  booksList({required this.collection});

  @override
  State<booksList> createState() => _booksListState();
}

class _booksListState extends State<booksList> {
  String? user = userPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collection),
        backgroundColor: '$user'.toUpperCase()=='STAFF'?Colors.orange:Colors.cyan,
      ),
      body: StreamBuilder<List<video>>(stream:readData(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('Something Went Wrong! ${snapshot.error}');
            }else if(snapshot.hasData){
              final book=snapshot.data;
              return ListView(
                scrollDirection: Axis.vertical,
                children: book!.map(buildList).toList(),
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
  Widget buildList(video book){
    return Link(
      target: LinkTarget.defaultTarget,
      uri:Uri.parse('${book.link}'),
      builder: (context, followLink) => GestureDetector(
        onTap: followLink,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ),
                  height: 100,
                  width: 120,
                  child: const Icon(Icons.picture_as_pdf,size: 100,color: Colors.white,),
                ),
                const SizedBox(width: 30.0,),
                Container(width: 1,color: Colors.black26,height: 100,),
                const SizedBox(width: 10,),
                Expanded(child: Text('${book.title}',style: const TextStyle(fontSize: 20,color: Colors.black),)),
              ],
            ),
          ),
        ),
      ),
    );}
  Stream<List<video>> readData() => FirebaseFirestore.instance
      .collection('${widget.collection} books')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => video.fromJson(doc.data())).toList());
}



