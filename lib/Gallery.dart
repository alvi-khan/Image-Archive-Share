import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageContainer.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key, required this.images, required this.selected, required this.toggleSelection}) : super(key: key);
  final List<File> images;
  final Set<int> selected;
  final Function toggleSelection;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Center(
            child: ImageContainer(
                selected: selected.contains(index),
                image: images[index],
                toggleSelect: () => toggleSelection(index)
            ),
          );
        }
    );
  }

}