class JokeTypeModel {
  final String type;

  JokeTypeModel({required this.type});

  factory JokeTypeModel.fromJson(String json) {
    return JokeTypeModel(type: json);
  }
}