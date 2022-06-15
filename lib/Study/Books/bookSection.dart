import 'package:flutter/material.dart';

class bookSection extends StatefulWidget {
  const bookSection({Key? key}) : super(key: key);

  @override
  State<bookSection> createState() => _bookSectionState();
}

class _bookSectionState extends State<bookSection> {
  final collections = ['C Language', 'Data Structures', 'Web Development'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Books'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('${collections[index]}'),
          trailing: Icon(Icons.arrow_forward_ios),
         // onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=>)),
        );
      },),
    );
  }
}
