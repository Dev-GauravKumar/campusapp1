class post {
  String? id;
  final String? name;
  final String? caption;
  final String? imageUrl;
  final String? filePath;
  post({required this.name, required this.caption, required this.id,required this.imageUrl,required this.filePath});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'caption': caption,
        'imageUrl':imageUrl,
        'filePath':filePath,
      };
  static post fromJson(Map<String, dynamic> json) =>
      post(name: json['name'], caption: json['caption'], id: json['id'], imageUrl: json['imageUrl'], filePath: json['filePath']);
}
