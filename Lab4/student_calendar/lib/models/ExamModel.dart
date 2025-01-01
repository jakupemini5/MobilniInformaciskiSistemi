class ExamModel {
  String? name;
  String? examName;
  DateTime? date;
  int? id;

  ExamModel({this.name, this.examName, this.date, this.id});

  ExamModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    examName = json['examName'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['examName'] = examName;
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}