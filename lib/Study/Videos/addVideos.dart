import 'package:campusapp/HomePageStaff.dart';
import 'package:campusapp/Study/Videos/videoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addVideos extends StatefulWidget {
  const addVideos({Key? key}) : super(key: key);

  @override
  State<addVideos> createState() => _addVideosState();
}

class _addVideosState extends State<addVideos> {
  final items = ['C Language', 'Data Structures', 'Web Development'];
  String? value;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController linkController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Videos'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                enableInteractiveSelection: true,
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
                enableInteractiveSelection: true,
                controller: linkController,
                decoration: const InputDecoration(
                  label: Text('Link'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Collection'),
                  underline: DropdownButtonHideUnderline(
                    child: Container(),
                  ),
                  isExpanded: true,
                  value: value,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(
                    () => this.value = value,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if(titleController.text==''||linkController.text==''||value==null)return;
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                final docVideo =
                    FirebaseFirestore.instance.collection('$value videos').doc();
                final newFile = video(
                    id: docVideo.id,
                    link: linkController.text,
                    title: titleController.text);
                final json = newFile.toJson();
                docVideo.set(json);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePageStaff(),
                    ),
                  );
                });
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
}
