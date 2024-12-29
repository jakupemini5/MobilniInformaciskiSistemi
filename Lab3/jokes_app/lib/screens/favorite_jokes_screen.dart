import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/services/local_storage_service.dart';
import 'package:jokes_app/widgets/blurred_app_bar.dart';
import 'package:jokes_app/widgets/joke_card.dart';

class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<FavoriteJokesScreen> createState() => FavoriteJokesScreenState();
}

class FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  late LocalStorageService localStorageService;
  List<JokeModel> jokes = [];

  @override
  void initState() {
    super.initState();
    localStorageService = LocalStorageService();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    final data = await localStorageService.getFavoriteJokes("favoriteJokes");
    setState(() {
      jokes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlurredAppBar(
        title: 'Favorite jokes',
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
