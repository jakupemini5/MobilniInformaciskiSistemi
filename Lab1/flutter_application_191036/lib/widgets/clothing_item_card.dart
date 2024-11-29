import 'package:flutter/material.dart';
import 'package:flutter_application_191036/widgets/clothing_item_details.dart';

class ClothingItemCard extends StatelessWidget {
  final int price;
  final String name;
  final String imageUrl;
  final String description;

  const ClothingItemCard({
    super.key,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the item detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClothingItemDetails(
              name: name,
              imageUrl: imageUrl,
              price: price,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        color: const Color.fromARGB(255, 0, 0, 0), // Adjust as needed
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
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // Image loaded, return the image
                      return child;
                    } else {
                      // Show a progress indicator while loading
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 50, color: Colors.black),
                ),
              ),
              Container(
                color: const Color.fromARGB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w200),
                    ),
                    Text(
                      "\$${price.toString()}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
