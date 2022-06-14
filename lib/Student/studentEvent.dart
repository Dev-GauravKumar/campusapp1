import 'dart:io';
import 'package:campusapp/Event/EventModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class studentEvent extends StatefulWidget {
  const studentEvent({Key? key}) : super(key: key);

  @override
  State<studentEvent> createState() => _studentEventState();
}

class _studentEventState extends State<studentEvent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<event>>(stream:readEvent(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Something Went Wrong! ${snapshot.error}');
          }else if(snapshot.hasData){
            final events=snapshot.data;
            return ListView(
              scrollDirection: Axis.vertical,
              children: events!.map(buildEvent).toList(),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildEvent(event event)=>ExpansionTile(
    tilePadding: const EdgeInsets.all(10.0),
    childrenPadding: const EdgeInsets.all(5.0),
    title: Text('${event.title}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    subtitle: Text('${event.selectedDate}\n(${event.selectedTime})'),
    children: [
      Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              event.fileUrl!=null?ElevatedButton(onPressed: ()=>openFile(url: '${event.fileUrl}',name: '${event.fileName}'), child: const Text('Attached File'),):Container(),
            ],
          )),
      Text('${event.discription}'),
    ],
  );

  Stream<List<event>> readEvent() => FirebaseFirestore.instance
      .collection('Events')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => event.fromJson(doc.data())).toList());

  Future openFile({required String url,required String? name})async{
    final file = await downloadFile(url,name!);
    if(file==null)return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }
  Future <File?> downloadFile(String url,String name)async{
    final appStorage= await getApplicationDocumentsDirectory();
    final file=File('${appStorage.path}/$name');
    try {
      final response= await Dio().get(url,options:  Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ));
      final raf= file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } on Exception{
      return null;
    }
  }
}
