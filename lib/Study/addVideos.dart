import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class addVideos extends StatefulWidget {
  const addVideos({Key? key}) : super(key: key);

  @override
  State<addVideos> createState() => _addVideosState();
}

class _addVideosState extends State<addVideos> {
  final items=['C Language','Data Structures','Web Development'];
  String? value;
  @override
  Widget build(BuildContext context) {
    TextEditingController linkController=TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Videos'),
        ),
        body: ListView(
          children: [
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
                padding: EdgeInsets.all(10.0),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey,width: 1),
                ),
                child: DropdownButton<String>(
                  hint: Text('Collection'),
                  underline: DropdownButtonHideUnderline(child: Container(),),
                  isExpanded: true,
                  value: value,
                  items: items.map(buildMenuItem).toList(),onChanged: (value)=>setState(()=>this.value=value,),
                ),
              ),
            ),
            ElevatedButton(onPressed: ()async{
              final docEvent=FirebaseFirestore.instance.collection('$value').doc();
              docEvent.set({'id':docEvent.id,'link':linkController.text});
            }, child: Text('Done'),),
          ],
        ),
      ),
    );
  }
  DropdownMenuItem<String>buildMenuItem(String item)=>DropdownMenuItem(child: Text(item),value: item,);
}
