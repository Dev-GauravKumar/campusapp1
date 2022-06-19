import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusapp/Study/Videos/playVideo.dart';
import 'package:campusapp/Study/Videos/videoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:campusapp/userPreferences.dart';

class videosList extends StatefulWidget {
  final String collection;
  const videosList({required this.collection});

  @override
  State<videosList> createState() => _videosListState();
}

class _videosListState extends State<videosList> {
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
    String? image=thumbnail('${video.link}');
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>playVideo(url: '${video.link}',collection: '${widget.collection}',),),),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 120,
                child: CachedNetworkImage(imageUrl: '$image'),
              ),
              const SizedBox(width: 30.0,),
              Container(width: 1,height: 100,color: Colors.black26,),
              const SizedBox(width: 10,),
              Expanded(child: Text('${video.title}',style: const TextStyle(fontSize: 20,color: Colors.black),)),
            ],
          ),
        ),
      ),
    );}

  Stream<List<video>> readData() => FirebaseFirestore.instance
      .collection('${widget.collection} videos')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => video.fromJson(doc.data())).toList());
 }
String? thumbnail(String url){
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return null;
  }

  return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
}