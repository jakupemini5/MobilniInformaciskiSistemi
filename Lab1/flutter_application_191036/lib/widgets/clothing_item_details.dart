import 'package:flutter/material.dart';
import 'package:flutter_application_191036/widgets/blurred_app_bar.dart';

class ClothingItemDetails extends StatelessWidget {
  final String name;
  final int price;
  final String imageUrl;

  const ClothingItemDetails({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlurredAppBar(
        title: name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image loaded
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
            // Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        "\$${price.toString()}",
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Item Description:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac tortor enim. Sed lacinia molestie diam, eu sollicitudin odio venenatis id. Suspendisse eget venenatis risus, in porttitor eros. Nam at velit quam. Pellentesque iaculis, lorem ac placerat pulvinar, diam lacus ultrices nunc, et mollis ligula ligula nec lorem. Maecenas vestibulum, arcu ut eleifend interdum, lorem purus consectetur ipsum, non bibendum nunc lacus dapibus erat. Nulla a vehicula diam. In libero lacus, viverra sed est ut, finibus interdum velit. Nullam vehicula tincidunt orci sit amet pretium. Praesent vel pharetra quam.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
