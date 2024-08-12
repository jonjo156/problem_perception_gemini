import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(
          top: 70,
          bottom: 34,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 8),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
