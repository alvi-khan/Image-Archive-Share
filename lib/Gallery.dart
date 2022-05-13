import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageContainer.dart';

class Gallery extends StatefulWidget {
  const Gallery(this.images, {Key? key}) : super(key: key);
  final List<File> images;

  @override
  State<StatefulWidget> createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  Set<int> selected = {};

  void toggleSelection(int index) {
    setState(() => selected.contains(index) ? selected.remove(index) : selected.add(index));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            shrinkWrap: true,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Center(
                child: ImageContainer(
                    selected: selected.contains(index),
                    image: widget.images[index],
                    toggleSelect: () => toggleSelection(index)
                ),
              );
            }
        ),
      ),
    );
  }
}