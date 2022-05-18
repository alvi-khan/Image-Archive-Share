import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:provider/provider.dart';

class ImageContainer extends StatelessWidget {
  ImageContainer(this.index, {Key? key}) : super(key: key);
  final int index;
  late ImageManager imageManager;

  @override
  Widget build(BuildContext context) {
    imageManager = Provider.of<ImageManager>(context);
    String image = imageManager.images[index];
    File imageFile = File(image);
    bool selected = imageManager.selected.contains(index);

    return GestureDetector(
      onTap: () => imageManager.toggleSelection(index),
      onLongPressStart: (_) => imageManager.updateFullScreenImage(imageFile),
      onLongPressEnd: (_) => imageManager.updateFullScreenImage(null),
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
                  child: Image.file(
                      imageFile,
                      cacheWidth: 400,
                      width: 200,
                      fit: BoxFit.cover
                  ),
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