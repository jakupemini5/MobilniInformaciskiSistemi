import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;

  const JokeTypeCard({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {  
    return GestureDetector(
      onTap: () => {

      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(10,5,10,5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: const Color.fromARGB(255, 0, 30, 44), // Adjust as needed
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,40,20,40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Text(
                      type,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w900,
                          ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
