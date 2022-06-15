class video {
  String? id;
  String? link;
  String? title;
  video({required this.id,required this.link,required this.title});
  Map<String,dynamic> toJson()=>{
    'id':id,
    'link':link,
    'title':title,
};
  static video fromJson(Map<String,dynamic>json)=>video(id: json['id'], link: json['link'],title: json['title']);
}