import 'dart:io';
import 'package:campusapp/HomePageStaff.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../Firebase_api.dart';
import 'post_Model.dart';
class AddNotice extends StatefulWidget {
  const AddNotice({Key? key}) : super(key: key);

  @override
  State<AddNotice> createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  final nameController = TextEditingController();
  final captionController = TextEditingController();
  String? filePath;
  String? imageUrl;
  String? imageName;
  File? image;
  UploadTask? task;
  Future pickImage(String method) async {
    try {
      final image = method == 'Camera'
          ? await ImagePicker().pickImage(source: ImageSource.camera)
          : await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageName = image.path.split('/').last;
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
       Text('Something Went Wrong $e');
    }
  }

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
          title: const Text('Post Notice'),
        ),
        body: ListView(
          children: [
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Your Name'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  label: Text('Caption'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.contain,
                      )
                    : const Text('No Image Selected'),
              ),),

            ElevatedButton(
                onPressed: () => pickImage('Camera'),
                child: const Text('Image From Camera')),
            ElevatedButton(onPressed: ()=>pickImage('Gallery'), child: const Text('Image From Gallery'),),
            ElevatedButton(
              onPressed: () async{
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                var name=nameController.text;
                var caption=captionController.text;
                await Post();
                createPost(name: name, caption: caption,imageUrl: imageUrl,filePath: filePath);
              },
              child: const Text('Post'),
            ),
            task != null ? buildUploadStatus(task!) : Container(),
          ],
        ),
      ),
    );
  }
  Future Post() async {
    if (image == null) return;
    final destination = 'Images/$imageName';
    task = FirebaseApi.uploadFile(destination, image!);
    if (task == null) return;
    setState(() {});
    final snapshot = await task!.whenComplete(() {});
    imageUrl = await snapshot.ref.getDownloadURL();
    filePath=snapshot.ref.fullPath;
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            return LinearProgressIndicator(value: progress,
              color: Colors.green,
            );
          } else {
            return Container();
          }
        },
      );
  Future createPost({required String name,required String? caption,required String? imageUrl,String? filePath})async{
    final docPost=FirebaseFirestore.instance.collection('Posts').doc();
    final newPost= post(name: name, caption: caption, id: docPost.id,imageUrl: imageUrl,filePath: filePath);
    final json=newPost.toJson();
    await docPost.set(json);
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePageStaff(),));
    });
  }
}