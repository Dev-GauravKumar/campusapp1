class video {
  String? id;
  String? link;
  video({required this.id,required this.link});
  static video fromJson(Map<String,dynamic>json)=>video(id: json['id'], link: json['link']);
}