import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
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
              setup ?? '',
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
              punchline ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
