import 'dart:io';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.selected, required this.image, required this.toggleSelect}) : super(key: key);

  final bool selected;
  final String image;
  final Function toggleSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleSelect(),
      child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent
              ),
              padding: selected ? const EdgeInsets.all(5) : EdgeInsets.zero,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(image), cacheWidth: 200, cacheHeight: 200),
              ),
            ),
            if (selected) const SelectedIcon()
            else  const Icon(Icons.circle_outlined, color: Colors.black54),
          ]
      ),
    );
  }
}

class SelectedIcon extends StatelessWidget {
  const SelectedIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
        ),
        child: const Icon(
            Icons.check_circle_rounded,
            color: Colors.blueAccent
        )
    );
  }
}