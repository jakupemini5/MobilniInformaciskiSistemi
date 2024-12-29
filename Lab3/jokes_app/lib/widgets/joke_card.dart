import 'package:flutter/material.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/services/local_storage_service.dart';
import 'package:jokes_app/services/notification_service.dart';

class JokeCard extends StatefulWidget {
  final String? type;
  final String? setup;
  final String? punchline;
  final int? id;

  const JokeCard({
    super.key,
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
  });

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  late LocalStorageService localStorageService;
  late NotificationService notificationService;
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    localStorageService = LocalStorageService();
    notificationService = NotificationService();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    if (widget.id == null) return;
    try {
      final data = await localStorageService.getFavoriteJokes("favoriteJokes");
      final isFavoriteJoke = data.any((x) => x.id == widget.id);
      setState(() {
        isFavorite = isFavoriteJoke;
      });
    } catch (e) {
      debugPrint('Error checking favorite joke: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addFavorite() async {
    if (widget.id == null) return;
    try {
      setState(() {
        isFavorite = !isFavorite;
      });
      // Fetch existing favorite jokes
      final data = await localStorageService.getFavoriteJokes("favoriteJokes");

      // Check if the joke already exists
      bool foundJoke = data.any((joke) => joke.id == widget.id);

      if (isFavorite) {
        if (!foundJoke) {
          // Create a new JokeModel with widget details
          JokeModel newJoke = JokeModel(
            id: widget.id!,
            type: widget.type ?? '',
            setup: widget.setup ?? '',
            punchline: widget.punchline ?? '',
          );

          // Add the new joke to the list
          data.add(newJoke);

          // Save the updated list to local storage
          await localStorageService.saveJsonList("favoriteJokes", data);
        }
      }
      else {
        var foundJokeModel = data.where((x) => x.id == widget.id);
        data.remove(foundJokeModel.first);
        await localStorageService.saveJsonList("favoriteJokes", data);
      }

      // Update UI state
    } catch (e) {
      debugPrint('Error adding favorite joke: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color.fromARGB(255, 5, 39, 56),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.setup ?? '',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.blueGrey.shade300),
            const SizedBox(height: 10),
            Text(
              widget.punchline ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                notificationService.showTestNotification();
              },
              child: Text('Send Test Notification'),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Aligns the content to the right
              children: [
                if (isLoading)
                  const CircularProgressIndicator(color: Colors.white)
                else
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_outline,
                      color: Colors.white,
                    ),
                    iconSize: 40,
                    tooltip: 'Make favorite',
                    onPressed: () async {
                      addFavorite();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
