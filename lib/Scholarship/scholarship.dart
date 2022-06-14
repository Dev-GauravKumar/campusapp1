import 'dart:io';
import 'package:campusapp/Scholarship/scholarModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class scholarship extends StatefulWidget {
  const scholarship({Key? key}) : super(key: key);

  @override
  State<scholarship> createState() => _scholarshipState();
}

class _scholarshipState extends State<scholarship> {
  @override
  DateTime? selectedDate = DateTime.now();
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
              Row(
                children: [
                  IconButton(onPressed: ()=>editEvent(scholar), icon: const Icon(Icons.edit),),
                  IconButton(onPressed: ()=>deleteScholar(scholar), icon: const Icon(Icons.delete),),
                ],
              )
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
  deleteScholar(scholar scholar){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Are You Sure?'),
      content: const Text('You Want To Delete This Scholarship'),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('No'),),
        TextButton(onPressed: ()async{
          final docEvent=FirebaseFirestore.instance.collection('Scholarships').doc(scholar.id);
          docEvent.delete();
          Navigator.pop(context);
          await delete(scholar.filePath);
        }, child: const Text('Yes'),),
      ],

    ));
  }
  Future<void> delete(String? ref) async {
    final storage = FirebaseStorage.instance;
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }
  Future datePicker(context) async {
    final DateTime current = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(current.year),
      lastDate: DateTime(current.year + 5),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
  editEvent(scholar scholar){
    TextEditingController titleController=TextEditingController();
    TextEditingController discriptionController=TextEditingController();
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Edit Fields'),
      actions: [
      TextField(
      controller: titleController,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
    ),
        const SizedBox(height: 10,),
        TextField(
          controller: discriptionController,
          decoration: const InputDecoration(
            labelText: 'Discription',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(onPressed: ()async{
            await datePicker(context);
            final date= '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}';
            final docEvent=FirebaseFirestore.instance.collection('Scholarships').doc(scholar.id);
            docEvent.update({'selectedDate':date});
          }, child: const Text('Expiry Date')),
        ),
        TextButton(onPressed: (){
          final docPost =
          FirebaseFirestore.instance.collection('Scholarships').doc(scholar.id);

          if (titleController.text != '' &&
              discriptionController.text != '') {
            docPost.update({
              'title': titleController.text,
              'discription': discriptionController.text,
            });
            Navigator.pop(context);
          } else if (titleController.text != '' &&
              discriptionController.text == '') {
            docPost.update({
              'title': titleController.text,
            });
            Navigator.pop(context);
          } else if (discriptionController.text != '' &&
              titleController.text == '') {
            docPost.update({
              'discription': discriptionController.text,
            });
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }, child: const Text('Done')),
      ],
    ));
  }
  Stream<List<scholar>> readEvent() => FirebaseFirestore.instance
      .collection('Scholarships')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => scholar.fromJson(doc.data())).toList());
}
