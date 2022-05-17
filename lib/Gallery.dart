import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageContainer.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key, required this.images, required this.selected, required this.toggleSelection, required this.toggleFullscreen}) : super(key: key);
  final List<String> images;
  final Set<int> selected;
  final Function toggleSelection;
  final Function toggleFullscreen;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Center(
            child: ImageContainer(
              selected: selected.contains(index),
              image: images[index],
              toggleSelect: () => toggleSelection(index),
              toggleFullscreen: (image) => toggleFullscreen(image),
            ),
          );
        }
    );
  }

}