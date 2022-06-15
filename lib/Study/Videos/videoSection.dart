import 'package:campusapp/Study/Videos/videosList.dart';
import 'package:flutter/material.dart';

class videoSection extends StatefulWidget {
  const videoSection({Key? key}) : super(key: key);

  @override
  State<videoSection> createState() => _videoSectionState();
}

class _videoSectionState extends State<videoSection> {
  final collections = ['C Language', 'Data Structures', 'Web Development'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Videos'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(collections[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            //leading: Container(child: Image.network(id("https://www.youtube.com/watch?v=CgpxdRlmeeE&list=PLk05cwASVVZvjId6c819zTqoV0WvZTT1f")??""),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => videosList(
                  collection: collections[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
