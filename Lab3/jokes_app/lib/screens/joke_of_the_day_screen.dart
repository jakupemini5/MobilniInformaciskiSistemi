import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/services/api_services.dart';
import 'package:jokes_app/widgets/blurred_app_bar.dart';
import 'package:jokes_app/widgets/joke_card.dart';

class JokeOfTheDayScreen extends StatefulWidget {
  const JokeOfTheDayScreen({super.key});

  @override
  State<JokeOfTheDayScreen> createState() => JokeOfTheDayScreenState();
}

class JokeOfTheDayScreenState extends State<JokeOfTheDayScreen> {
  late ApiService apiService;
  JokeModel? joke;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    final data = await apiService.getRandomJokeOfTheDay();
      setState(() {
        joke = data;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlurredAppBar(
        title: "Joke of the day",
      ),
      body: joke == null
          ? const Center(child: CircularProgressIndicator())
          : JokeCard(
                  type: joke!.type,
                  id: joke!.id,
                  setup: joke!.setup,
                  punchline: joke!.punchline,
                )
    );
  }
}