import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(path), height: 220, fit: BoxFit.cover),
      ),
    );
  }
}
