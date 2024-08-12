import 'package:flutter/material.dart';

class ResultsHeading extends StatelessWidget {
  final String title;
  final Icon icon;
  const ResultsHeading({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        icon,
      ],
    );
  }
}
