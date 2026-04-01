import 'package:flutter/material.dart';

class TutorialCard extends StatelessWidget {
  const TutorialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.blueGrey[50],
      margin: const EdgeInsets.only(bottom: 20),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How to use",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 10),
            Text("• Place your ID card on a flat, plain surface."),
            Text("• Ensure there is proper lighting (avoid glare/shadows)."),
            Text("• Hold the camera steady and make sure the ID is fully visible."),
            Text("• Capture or pick a clear image for best results."),
          ],
        ),
      ),
    );
  }
}
