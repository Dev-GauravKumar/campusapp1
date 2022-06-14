class event{
  final String? id;
  final String? title;
  final String? discription;
  final String? fileUrl;
  final String? filePath;
  final String? selectedDate;
  final String? selectedTime;
  final String? fileName;
  event({required this.id,required this.title,required this.discription, required this.fileUrl, required this.filePath,required this.selectedDate,required this.selectedTime,required this.fileName});
  Map<String, dynamic> toJson()=>{
    'id': id,
    'title':title,
    'discription':discription,
    'fileUrl':fileUrl,
    'filePath': filePath,
    'selectedDate':selectedDate,
    'selectedTime':selectedTime,
    'fileName':fileName
  };
  static event fromJson(Map<String, dynamic> json)=>event(id: json['id'], title: json['title'], discription: json['discription'], fileUrl: json['fileUrl'], filePath: json['filePath'], selectedDate: json['selectedDate'],selectedTime: json['selectedTime'],fileName: json['fileName']);
}