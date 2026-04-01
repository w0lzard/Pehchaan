import 'package:flutter/material.dart';

class ResultPanel extends StatelessWidget {
  const ResultPanel({
    super.key,
    required this.title,
    required this.text,
    required this.background,
    required this.textStyle,
  });

  final String title;
  final String text;
  final Color? background;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.blueGrey[700],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(text, style: textStyle),
        ),
      ],
    );
  }
}
