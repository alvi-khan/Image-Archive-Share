import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_archive_share/Gallery.dart';
import 'package:image_archive_share/ImageLoadingError.dart';
import 'package:image_archive_share/ShareButton.dart';

class Body extends StatefulWidget {
  const Body(this.images, {Key? key}) : super(key: key);
  final List<File> images;

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Body> {
  Set<int> selected = {};

  void toggleSelection(int index) {
    setState(() => selected.contains(index) ? selected.remove(index) : selected.add(index));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const ImageLoadingError("No images found.");
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Gallery(
                images: widget.images,
                selected: selected,
                toggleSelection: (index) => toggleSelection(index)
            ),
          )
        ),
        ShareButton(
            selected: selected,
            images: widget.images,
        )
      ],
    );
  }
}