import 'package:flutter/material.dart';

class ExternalLogPanel extends StatelessWidget {
  final imagePath;
  final void Function()? onTap;
  const ExternalLogPanel({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 80,
        height: 80,
        child: Image(
          image: AssetImage(
            imagePath,
          ),
        ),
      ),
    );
  }
}
