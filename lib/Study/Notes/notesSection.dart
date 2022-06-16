import 'package:campusapp/Study/Notes/notesList.dart';
import 'package:flutter/material.dart';

class notesSection extends StatefulWidget {
  const notesSection({Key? key}) : super(key: key);

  @override
  State<notesSection> createState() => _notesSectionState();
}

class _notesSectionState extends State<notesSection> {
  final collections = ['C Language', 'Data Structures', 'Web Development'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${collections[index]}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>notesList(collection: '${collections[index]}')),),
          );
        },),
    );
  }
}
