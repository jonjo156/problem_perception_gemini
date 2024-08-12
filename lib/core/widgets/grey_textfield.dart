import 'package:flutter/material.dart';

class GreyTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  const GreyTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).disabledColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: TextField(
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.normal),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
