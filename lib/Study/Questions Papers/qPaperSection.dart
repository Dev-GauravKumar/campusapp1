import 'package:campusapp/Study/Questions%20Papers/qPaperList.dart';
import 'package:flutter/material.dart';
import 'package:campusapp/userPreferences.dart';

class qPaperSection extends StatefulWidget {
  const qPaperSection({Key? key}) : super(key: key);

  @override
  State<qPaperSection> createState() => _qPaperSectionState();
}

class _qPaperSectionState extends State<qPaperSection> {
  String? user = userPreferences.getUser();
  final collections = ['C Language', 'Data Structures', 'Web Development'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: '${user}'.toUpperCase()=='STAFF'?Colors.orange:Colors.cyan,
        title: const Text('Questions Papers'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(collections[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>qPaperList(collection: '${collections[index]}')),),
            ),
          );
        },),
    );
  }
}
