import 'package:campusapp/Study/videosList.dart';
import 'package:flutter/material.dart';

class videoSection extends StatefulWidget {
  const videoSection({Key? key}) : super(key: key);

  @override
  State<videoSection> createState() => _videoSectionState();
}

class _videoSectionState extends State<videoSection> {
  final collections = ['C language', 'Data Structures', 'Web Development'];
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

  String? id(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
}
