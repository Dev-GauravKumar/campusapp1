import 'dart:io';
import 'package:campusapp/Firebase_api.dart';
import 'package:campusapp/HomePageStaff.dart';
import 'package:campusapp/Scholarship/scholarModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
class addScholarship extends StatefulWidget {
  const addScholarship({Key? key}) : super(key: key);

  @override
  State<addScholarship> createState() => _addScholarshipState();
}

class _addScholarshipState extends State<addScholarship> {
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  PlatformFile? file;
  UploadTask? task;
  String? fileUrl;
  String? filePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Scholarship'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                minLines: 1,
                maxLines: 100,
                controller: discriptionController,
                decoration: const InputDecoration(
                  label: Text('Discription'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(), color: Colors.white),
                      child: file == null
                          ? const Text('No File Selected')
                          : file!.extension == 'pdf'
                          ? Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 90,
                            color: Colors.red,
                            child: const Center(
                                child: Text(
                                  'Pdf',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          Expanded(child: Text(file!.name)),
                        ],
                      )
                          : file!.extension == 'mp3'
                          ? Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 90,
                            color: Colors.orange,
                            child: const Center(
                                child: Text(
                                  'Mp3',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          Expanded(child: Text(file!.name)),
                        ],
                      )
                          : file!.extension == 'jpg' ||
                          file!.extension == 'png'
                          ? Column(
                        children: [
                          Container(
                              height: 50,
                              width: 90,
                              child: Image.file(
                                File('${file!.path}'),
                                fit: BoxFit.cover,
                              )),
                          Expanded(child: Text(file!.name)),
                        ],
                      )
                          : const Text('Unsupported File Format'),
                    ),
                    onTap: () {
                      if (file == null) return;
                      openFile(file);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async => await pickFile(),
                    child: const Text('Add File'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async => await datePicker(context),
              child: const Text('Select Expiry'),
            ),
            ElevatedButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                if(file!=null)await uploadFile();
                await createEvent();
                setState(() {});
              },
              child: const Text('Done'),
            ),
            task!=null?uploadStatus(task!):Container(),
          ],
        ),
      ),
    );
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
  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowCompression: true);
    if (result == null) return;
    setState(() {
      file = result.files.first;
    });
  }

  void openFile(PlatformFile? file) {
    OpenFile.open('${file!.path}');
  }
  Future uploadFile() async {
    if (file == null) return;
    const uuid=Uuid();
    final id=uuid.v1();
    final destination = 'Scholarships/$id';
    task = FirebaseApi.uploadFile(destination, File('${file!.path}'));
    if (task == null) return;
    setState(() {});
    final snapshot = await task!.whenComplete(() => () {});
    fileUrl = await snapshot.ref.getDownloadURL();
    filePath = snapshot.ref.fullPath;
  }
  Future createEvent() async {
    final title=titleController.text;
    final discription=discriptionController.text;
    final date= '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}';
    final filename;
    if(file==null){
      filename=null;
    }else{
      filename=file!.name;
    }
    final docEvent = FirebaseFirestore.instance.collection('Scholarships').doc();
    final newEvent = scholar(
      id: docEvent.id,
      title: title,
      discription: discription,
      fileUrl: fileUrl,
      filePath: filePath,
      selectedDate: date,
      fileName: filename,
    );
    final json = newEvent.toJson();
    await docEvent.set(json);
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePageStaff(),));
    });
  }
  Widget uploadStatus(UploadTask task)=>StreamBuilder<TaskSnapshot>(stream: task.snapshotEvents,builder: (context,snapshot){
    if(snapshot.hasData){
      final data= snapshot.data;
      final progress=data!.bytesTransferred/data.totalBytes;
      return LinearProgressIndicator(value: progress,
        color: Colors.green,
      );
    }else{
      return Container();
    }
  });
}
