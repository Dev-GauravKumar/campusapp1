import 'dart:io';
import 'package:campusapp/Event/EventModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay.now();
  bool _customTileExpanded=false;
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

  Widget buildEvent(event event)=>Card(
    child: ExpansionTile(
      onExpansionChanged:(bool expanded){
        setState((){
          _customTileExpanded=expanded;
        });
      },
      iconColor: Colors.orange,
      trailing: _customTileExpanded?Icon(Icons.keyboard_arrow_down_outlined,size: 40,):Icon(Icons.keyboard_arrow_up_outlined,size: 40,),
      tilePadding: const EdgeInsets.all(10.0),
      childrenPadding: const EdgeInsets.all(5.0),
      title: Text('${event.title}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
      subtitle: Text('${event.selectedDate}\t\t(${event.selectedTime})',style: TextStyle(color: Colors.black),),
      children: [
        Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            color: Color.fromRGBO(243, 246, 251,1),
            border: Border.all(color: Colors.black26,width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${event.discription}'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            event.fileUrl==null?Container():Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange,fixedSize: Size(150,50)),
                    onPressed: ()=>openFile(url: '${event.fileUrl}', name: '${event.fileName}'), child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Icon(Icons.download),
                  Text('Attached File')
                ],))),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: IconButton(
                      onPressed: ()=>editEvent(event),
                      icon: Icon(Icons.edit,color: Colors.white,),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: IconButton(
                      onPressed: () =>deleteEvent(event),
                      icon: Icon(Icons.delete,color: Colors.white,),
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

  Stream<List<event>> readEvent() => FirebaseFirestore.instance
      .collection('Events')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => event.fromJson(doc.data())).toList());

  deleteEvent(event event){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Are You Sure?'),
      content: const Text('You Want To Delete This Event'),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('No',style: TextStyle(color: Colors.black),),),
        TextButton(onPressed: ()async{
          final docEvent=FirebaseFirestore.instance.collection('Events').doc(event.id);
          docEvent.delete();
          Navigator.pop(context);
          await delete(event.filePath);
        }, child: const Text('Yes',style: TextStyle(color: Colors.orange),),),
      ],

    ));
  }
  editEvent(event event){
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
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: ()async{
              await datePicker(context);
              final date= '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}';
              final docEvent=FirebaseFirestore.instance.collection('Events').doc(event.id);
              docEvent.update({'selectedDate':date});
            }, child: Text('Date')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: ()async{
              await timePicker(context);
              final time='${selectedTime!.hour.toString().padLeft(2,'0')}:${selectedTime!.minute.toString().padLeft(2,'0')}';
              final docEvent=FirebaseFirestore.instance.collection('Events').doc(event.id);
              docEvent.update({'selectedTime':time});
              }, child: Text('Time')),
          ],
        ),
        TextButton(
            onPressed: (){
          final docPost =
          FirebaseFirestore.instance.collection('Events').doc(event.id);

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
  Future timePicker(context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime!,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
  Future<void> delete(String? ref) async {
    final storage = FirebaseStorage.instance;
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }
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
