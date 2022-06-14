import 'dart:io';
import 'package:campusapp/Scholarship/scholarModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class studentScholarship extends StatefulWidget {
  const studentScholarship({Key? key}) : super(key: key);

  @override
  State<studentScholarship> createState() => _studentScholarshipState();
}

class _studentScholarshipState extends State<studentScholarship> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<scholar>>(stream:readEvent(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Something Went Wrong! ${snapshot.error}');
          }else if(snapshot.hasData){
            final scholar=snapshot.data;
            return ListView(
              scrollDirection: Axis.vertical,
              children: scholar!.map(buildEvent).toList(),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
  Widget buildEvent(scholar scholar)=>ExpansionTile(
    tilePadding: const EdgeInsets.all(10.0),
    childrenPadding: const EdgeInsets.all(5.0),
    title: Text('${scholar.title}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    subtitle: Text('Last Date: ${scholar.selectedDate}'),
    children: [
      Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              scholar.fileUrl!=null?ElevatedButton(onPressed: ()=>openFile(url: '${scholar.fileUrl}',name: '${scholar.fileName}'), child: const Text('Attached File'),):Container(),
            ],
          )),
      Text('${scholar.discription}'),
    ],
  );
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

  Stream<List<scholar>> readEvent() => FirebaseFirestore.instance
      .collection('Scholarships')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => scholar.fromJson(doc.data())).toList());
}
