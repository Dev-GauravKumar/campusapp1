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
      iconColor: Color.fromRGBO( 	255, 107, 3,1),
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
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color.fromRGBO( 	255, 107, 3,1),fixedSize: Size(150,50)),
                    onPressed: ()=>openFile(url: '${scholar.fileUrl}', name: '${scholar.fileName}'), child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.download),
                    Text('Attached File')
                  ],))),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: IconButton(
                      onPressed: ()=>editEvent(scholar),
                      icon: const Icon(Icons.edit,color: Colors.white,),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO( 	255, 107, 3,1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: IconButton(
                      onPressed: () =>deleteScholar(scholar),
                      icon: const Icon(Icons.delete,color: Colors.white,),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
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
  deleteScholar(scholar scholar){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Are You Sure?'),
      content: const Text('You Want To Delete This Scholarship'),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('No',style: TextStyle(color: Colors.black),),),
        TextButton(onPressed: ()async{
          final docEvent=FirebaseFirestore.instance.collection('Scholarships').doc(scholar.id);
          docEvent.delete();
          Navigator.pop(context);
          await delete(scholar.filePath);
        }, child: const Text('Yes',style: TextStyle(color: Colors.orange),),),
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
          minLines: 1,
          maxLines: 100,
          controller: discriptionController,
          decoration: const InputDecoration(
            labelText: 'Discription',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: ()async{
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
        }, child: const Text('Done',style: TextStyle(color: Colors.orange),)),
      ],
    ));
  }
  Stream<List<scholar>> readEvent() => FirebaseFirestore.instance
      .collection('Scholarships')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => scholar.fromJson(doc.data())).toList());
}
