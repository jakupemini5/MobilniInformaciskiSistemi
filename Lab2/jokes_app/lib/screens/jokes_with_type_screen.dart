import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/blurred_app_bar.dart';
import 'package:jokes_app/widgets/joke_card.dart';

class JokesWithTypeScreen extends StatefulWidget {
  const JokesWithTypeScreen({super.key, required this.type});

  final String type;

  @override
  State<JokesWithTypeScreen> createState() => JokesWithTypeScreenState();
}

class JokesWithTypeScreenState extends State<JokesWithTypeScreen> {
  late String type;
  late ApiService apiService;
  List<JokeModel> jokes = [];


  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    type = widget.type;
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    final data = await apiService.getJokesWithType(type);
      setState(() {
        jokes = data;
      });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: BlurredAppBar(
      title: type,
    ),
    body: jokes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              return JokeCard(
                  type: jokes[index].type,
                  id: jokes[index].id,
                  setup: jokes[index].setup,
                  punchline: jokes[index].punchline,
                );
            },
          ),
  );
}

}
