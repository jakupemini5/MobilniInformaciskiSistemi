class ExamModel {
  String? name;
  String? examName;
  DateTime? date;
  double? longitude;
  double? latitude;
  int? id;

  ExamModel({
    this.name,
    this.examName,
    this.date,
    this.id,
    this.longitude,
    this.latitude,
  });

  ExamModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    examName = json['examName'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['examName'] = examName;
    data['date'] = date?.toIso8601String(); // Convert DateTime to ISO 8601 string
    data['id'] = id;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
