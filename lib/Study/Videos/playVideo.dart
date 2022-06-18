import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class playVideo extends StatefulWidget {
  String url;
  String collection;
  playVideo({Key? key, required this.url,required this.collection}) : super(key: key);

  @override
  State<playVideo> createState() => _playVideoState();
}

class _playVideoState extends State<playVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller=YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: YoutubePlayerFlags(
        mute: false,
      loop: true,
      autoPlay: true,
    ),
    )..addListener(() {
      if(mounted){
        setState((){});
      }
    });
  }
  void deactivate(){
    _controller.pause();
    super.dispose();
  }
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (BuildContext , player ) =>Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('${widget.collection}'),
        ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: player,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(_controller.value.metaData.title,style: TextStyle(fontSize: 25,color: Colors.black),),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Channel : ${_controller.value.metaData.author}',style: TextStyle(fontSize: 25,color: Colors.black),),
            ),
          ),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Duration : ${_controller.value.metaData.duration.inHours} Hours',style: TextStyle(fontSize: 25,color: Colors.black),),
            ),
          ),

        ],
      ),
    ),

    );
  }
}
