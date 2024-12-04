import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BlurredAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0), // Adjust blur intensity
        child: AppBar(
          backgroundColor: Colors.black.withOpacity(0.0), // Semi-transparent black
          elevation: 0, // Remove shadow
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the height for the app bar
}
