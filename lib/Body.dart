import 'package:flutter/material.dart';
import 'package:image_archive_share/FullScreenImage.dart';
import 'package:image_archive_share/Gallery.dart';
import 'package:image_archive_share/ImageLoadingError.dart';
import 'package:image_archive_share/ShareButton.dart';

class Body extends StatefulWidget {
  const Body(this.images, {Key? key}) : super(key: key);
  final List<String> images;

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin{
  Set<int> selected = {};
  String fullScreenImage = "";

  void toggleSelection(int index) {
    setState(() => selected.contains(index) ? selected.remove(index) : selected.add(index));
  }

  void setFullScreenImage(image) {
    setState(() => fullScreenImage = image);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const ImageLoadingError("No images found.");
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Gallery(
                    images: widget.images,
                    selected: selected,
                    toggleSelection: (index) => toggleSelection(index),
                    toggleFullscreen: (image) => setFullScreenImage(image),
                  ),
                )
            ),
            ShareButton(
              selected: selected,
              images: widget.images,
            )
          ],
        ),
        IgnorePointer(
          child: Visibility(
            visible: fullScreenImage != "",
            child: FullScreenImage(image: fullScreenImage),
          ),
        )
      ]
    );
  }
}