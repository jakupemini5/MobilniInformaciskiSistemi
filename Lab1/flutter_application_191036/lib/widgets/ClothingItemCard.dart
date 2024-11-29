import 'package:flutter/material.dart';

class ClothingItemCard extends StatelessWidget {
  final int price;
  final String name;
  final String imageUrl;

  const ClothingItemCard({
    super.key,
    required this.price,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      color: Color.fromARGB(255, 0, 0, 0), // Adjust as needed
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Expanded(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 50, color: Colors.black),
              ),
            ),
             Container(
              color: Color.fromARGB(0, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${name}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w200),
                  ),
                  Text(
                    "\$${price.toString()}",
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
