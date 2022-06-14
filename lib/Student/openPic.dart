import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class openPic extends StatelessWidget {
  final imageUrl;
  const openPic({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(
        child: CachedNetworkImage(imageUrl: imageUrl,progressIndicatorBuilder: (context,url,download)=>CircularProgressIndicator(
          value: download.progress,
        ),),
      ),
    ),);
  }
}
