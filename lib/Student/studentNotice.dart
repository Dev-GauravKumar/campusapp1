import 'dart:io';
import 'package:campusapp/Firebase_api.dart';
import 'openPic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:campusapp/Post/post_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
class studentNotice extends StatefulWidget {
  const studentNotice({Key? key}) : super(key: key);

  @override
  _studentNoticeState createState() => _studentNoticeState();
}

class _studentNoticeState extends State<studentNotice> {
  var imageName;
  File? imageTemp=null;
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<post>>(
        stream: readPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something Went Wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView(
              scrollDirection: Axis.vertical,
              children: posts.map(buildPost).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildPost(post post) => Container(
    height: 300,
    width: 150,
    child: Card(
      elevation: 10,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${post.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Caption(
            caption: post.caption,
            imageUrl: post.imageUrl,
          ),
          Photo(post),
        ],
      ),
    ),
  );
  Stream<List<post>> readPost() => FirebaseFirestore.instance
      .collection('Posts')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => post.fromJson(doc.data())).toList());
  deletePost(post post) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are You Sure?'),
          content: const Text('You Want To Delete This Post'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async{
                final docPost =
                FirebaseFirestore.instance.collection('Posts').doc(post.id);
                docPost.delete();
                Navigator.pop(context);
                await delete(post.filePath);
              },
              child: const Text('Yes'),
            ),
          ],
        ));
  }
  editPost(post post) {
    final nameController = TextEditingController();
    final captionController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Fields'),
        actions: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: captionController,
            decoration: const InputDecoration(
              labelText: 'Caption',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 50,
              width: 50,
              child: post.imageUrl==null?Container():CachedNetworkImage(imageUrl: '${post.imageUrl}'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: ()async{
                  await addImage(post);
                },
                child: const Text('Add Image'),
              ),
              ElevatedButton(
                onPressed: () async {
                  delete(post.filePath);
                  final docPost=FirebaseFirestore.instance.collection('Posts').doc(post.id);
                  await docPost.update({'imageUrl':null,'filePath':null});
                  setState(() {});
                },
                child: const Text('Delete Image'),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              final docPost =
              FirebaseFirestore.instance.collection('Posts').doc(post.id);
              if (nameController.text != '' &&
                  captionController.text != '') {
                docPost.update({
                  'name': nameController.text,
                  'caption': captionController.text,
                });
                Navigator.pop(context);
              } else if (nameController.text != '' &&
                  captionController.text == '') {
                docPost.update({
                  'name': nameController.text,
                });
                Navigator.pop(context);
              } else if (captionController.text != '' &&
                  nameController.text == '') {
                docPost.update({
                  'caption': captionController.text,
                });
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),);
  }
  Future addImage(post post) async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageName=image.path.split('/').last;
      setState(() {
        imageTemp = File(image.path);
      });
    } on PlatformException catch (e) {
      Text('Something Went Wrong $e');
    }
    if(post.filePath!=null){
      await delete(post.filePath);
    }
    final destination='Images/$imageName';
    task= FirebaseApi.uploadFile(destination, imageTemp!);
    if(task==null)return;
    setState(() {});
    final snapshot= await task!.whenComplete(() => (){});
    final url=await snapshot.ref.getDownloadURL();
    final filePath= snapshot.ref.fullPath;
    final docPost=FirebaseFirestore.instance.collection('Posts').doc(post.id);
    await docPost.update({'imageUrl':url,'filePath':filePath});
    setState(() {});
  }
  delete(String? ref) async {
    final storage = FirebaseStorage.instance;
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }
  Widget Photo(post post) {
    return post.imageUrl != null
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 400,
        child: InkWell(
          child: CachedNetworkImage(imageUrl: '${post.imageUrl}',fit: BoxFit.cover,progressIndicatorBuilder: (context,url,download)=>CircularProgressIndicator(
            value: download.progress,
          ),
          ),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>openPic(imageUrl: post.imageUrl,))),
        ),
      ),
    )
        : Container();
  }
}


class Caption extends StatelessWidget {
  final String? caption;
  final String? imageUrl;
  const Caption({Key? key, required this.caption, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: caption == null
            ? Container()
            : ReadMoreText(
          '$caption',
          style: const TextStyle(
            color: Colors.black,
          ),
          trimCollapsedText: 'Read More',
          trimExpandedText: 'Read Less',
          trimMode: TrimMode.Line,
          trimLines: imageUrl == null ? 15 : 4,
        ),
      ),
    );
  }
}
