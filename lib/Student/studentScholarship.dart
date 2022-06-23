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
  bool _customTileExpanded=false;
  DateTime? selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<scholar>>(stream:readEvent(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Something Went Wrong! ${snapshot.error}');
          }else if(snapshot.hasData){
            final scholar=snapshot.data;
            return Stack(
              children:[
                Text('Scholarships',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ListView(
                  scrollDirection: Axis.vertical,
                  children: scholar!.map(buildEvent).toList(),
              ),
                ),
          ],
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
  Widget buildEvent(scholar scholar)=>Card(
    child: ExpansionTile(
      onExpansionChanged:(bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
      textColor: Colors.black,
      iconColor: Color.fromRGBO( 	112,229,177,1),
      trailing: _customTileExpanded?const Icon(Icons.keyboard_arrow_down_outlined,size: 40,):const Icon(Icons.keyboard_arrow_up_outlined,size: 40,),
      tilePadding: const EdgeInsets.all(10.0),
      childrenPadding: const EdgeInsets.all(5.0),
      title: Text('${scholar.title}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      subtitle: Text('Last Date: ${scholar.selectedDate}'),
      children: [
        Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(243, 246, 251,1),
            border: Border.all(color: Colors.black26,width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${scholar.discription}'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            scholar.fileUrl==null?Container():Padding(
                padding: const EdgeInsets.only(left: 100,top: 8,bottom: 8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                        shadowColor: Color.fromRGBO( 	112,229,177,1),
                        primary: Color.fromRGBO( 	112,229,177,1),fixedSize: const Size(150,50)),
                    onPressed: ()=>openFile(url: '${scholar.fileUrl}', name: '${scholar.fileName}'), child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.download),
                    Text('Attached File')
                  ],))),
          ],
        ),
      ],
    ),
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
