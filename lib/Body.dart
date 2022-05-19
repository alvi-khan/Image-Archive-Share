import 'package:flutter/material.dart';
import 'package:image_archive_share/ClearButton.dart';
import 'package:image_archive_share/FullScreenImage.dart';
import 'package:image_archive_share/Gallery.dart';
import 'package:image_archive_share/ImageLoadingError.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:image_archive_share/ShareButton.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin{
  late ImageManager imageManager;

  @override
  Widget build(BuildContext context) {
    imageManager = Provider.of<ImageManager>(context);

    if (imageManager.images.isEmpty) {
      return const ImageLoadingError("No images found.");
    }

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Gallery(),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
             children: [
               ShareButton(),
               const SizedBox(width: 20),
               const ClearButton()
             ],
            ),
          ),
        ),
        IgnorePointer(
          child: Visibility(
            visible: imageManager.fullScreenImage != null ,
            child: FullScreenImage(),
          ),
        )
      ]
    );
  }
}