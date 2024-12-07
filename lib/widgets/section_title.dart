import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPress;
  const SectionTitle({super.key, required this.title, this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: icon != null && onPress != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (icon != null && onPress != null)
            const SizedBox(
              width: 30,
            ),
          AutoSizeText(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          if (icon != null && onPress != null)
            IconButton(
              onPressed: () => onPress,
              icon: Icon(icon),
              iconSize: 30,
            )
        ]);
  }
}
