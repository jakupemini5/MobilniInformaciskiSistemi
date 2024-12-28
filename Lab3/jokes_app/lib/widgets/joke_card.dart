import 'package:flutter/material.dart';
import 'package:jokes_app/services/local_storage_service.dart';

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
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    localStorageService = LocalStorageService();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    if (widget.id == null) return;
    try {
      final data = await localStorageService.GetFavoriteJokes("favoriteJokes");
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
                  // Add functionality to toggle the favorite state
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  // Update local storage here if necessary
                },
              ),
          ],
        ),
      ),
    );
  }
}
