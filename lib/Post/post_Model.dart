class post {
  String? id;
  final String? name;
  final String? title;
  final String? caption;
  final String? imageUrl;
  final String? filePath;
  post({required this.name, required this.caption, required this.id,required this.imageUrl,required this.filePath,required this.title});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'caption': caption,
        'imageUrl':imageUrl,
        'filePath':filePath,
        'title':title
      };
  static post fromJson(Map<String, dynamic> json) =>
      post(name: json['name'], caption: json['caption'], id: json['id'], imageUrl: json['imageUrl'], filePath: json['filePath'],title: json['title']);
}
