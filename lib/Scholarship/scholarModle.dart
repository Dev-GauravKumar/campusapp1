class scholar{
  final String? id;
  final String? title;
  final String? discription;
  final String? fileUrl;
  final String? filePath;
  final String? selectedDate;
  final String? fileName;
  scholar({required this.id,required this.title,required this.discription, required this.fileUrl, required this.filePath,required this.selectedDate,required this.fileName});
  Map<String, dynamic> toJson()=>{
    'id': id,
    'title':title,
    'discription':discription,
    'fileUrl':fileUrl,
    'filePath': filePath,
    'selectedDate':selectedDate,
    'fileName':fileName
  };
  static scholar fromJson(Map<String, dynamic> json)=>scholar(id: json['id'], title: json['title'], discription: json['discription'], fileUrl: json['fileUrl'], filePath: json['filePath'], selectedDate: json['selectedDate'],fileName: json['fileName']);
}