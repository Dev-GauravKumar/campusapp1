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

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  var imageName;
  File? imageTemp = null;
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
        height: 315,
        width: 150,
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${post.title}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${post.name}',style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
              Photo(post),
              Caption(
                caption: post.caption,
                imageUrl: post.imageUrl,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: IconButton(
                        onPressed: () =>editPost(post),
                        icon: const Icon(Icons.edit,color: Colors.white,),
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
                        onPressed: () =>deletePost(post),
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
                  child: const Text('No',style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                  onPressed: () async {
                    final docPost = FirebaseFirestore.instance
                        .collection('Posts')
                        .doc(post.id);
                    docPost.delete();
                    Navigator.pop(context);
                    await delete(post.filePath);
                  },
                  child: const Text('Yes',style: TextStyle(color: Colors.orange),),
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
            minLines: 1,
            maxLines: 100,
            decoration: const InputDecoration(
              labelText: 'Discription',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 50,
              width: 50,
              child: post.imageUrl == null
                  ? Container()
                  : CachedNetworkImage(imageUrl: '${post.imageUrl}'),
            ),
          ),
          Row(
            mainAxisAlignment: post.imageUrl==null?MainAxisAlignment.start:MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () async {
                  await addImage(post);
                },
                child: const Text('Add Image'),
              ),
              post.imageUrl==null?Container():ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  delete(post.filePath);
                  final docPost = FirebaseFirestore.instance
                      .collection('Posts')
                      .doc(post.id);
                  await docPost.update({'imageUrl': null, 'filePath': null});
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
              if (nameController.text != '' && captionController.text != '') {
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
            child: const Text('Done',style: TextStyle(color: Colors.orange),),
          ),
        ],
      ),
    );
  }

  Future addImage(post post) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageName = image.path.split('/').last;
      setState(() {
        imageTemp = File(image.path);
      });
    } on PlatformException catch (e) {
      Text('Something Went Wrong $e');
    }
    if (post.filePath != null) {
      await delete(post.filePath);
    }
    final destination = 'Images/$imageName';
    task = FirebaseApi.uploadFile(destination, imageTemp!);
    if (task == null) return;
    setState(() {});
    final snapshot = await task!.whenComplete(() => () {});
    final url = await snapshot.ref.getDownloadURL();
    final filePath = snapshot.ref.fullPath;
    final docPost = FirebaseFirestore.instance.collection('Posts').doc(post.id);
    await docPost.update({'imageUrl': url, 'filePath': filePath});
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
              height: 120,
              width: 400,
              child: InkWell(
                child: CachedNetworkImage(
                  imageUrl: '${post.imageUrl}',
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, download) =>
                      CircularProgressIndicator(
                    value: download.progress,
                  ),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => openPic(
                              imageUrl: post.imageUrl,
                            ))),
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
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                  '$caption',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  trimCollapsedText: 'Read More',
                  trimExpandedText: 'Read Less',
                  trimMode: TrimMode.Line,
                  trimLines: imageUrl == null ? 10 : 4,
          moreStyle: const TextStyle(color: Colors.orange),
                lessStyle: const TextStyle(color: Colors.orange),
                ),
            ),
      ),
    );
  }
}
