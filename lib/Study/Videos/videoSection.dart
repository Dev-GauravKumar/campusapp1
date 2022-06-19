import 'package:campusapp/Study/Videos/videosList.dart';
import 'package:flutter/material.dart';
import 'package:campusapp/userPreferences.dart';

class videoSection extends StatefulWidget {
  const videoSection({Key? key}) : super(key: key);

  @override
  State<videoSection> createState() => _videoSectionState();
}

class _videoSectionState extends State<videoSection> {
  String? user = userPreferences.getUser();
  final collections = ['C Language', 'Data Structures', 'Web Development'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: '${user}'.toUpperCase()=='STAFF'?Colors.orange:Colors.cyan,
        title: const Text('Videos'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(collections[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => videosList(
                    collection: collections[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
