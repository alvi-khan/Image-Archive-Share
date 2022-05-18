import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:provider/provider.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({Key? key}) : super(key: key);
  late ImageManager imageManager;

  @override
  Widget build(BuildContext context) {
    imageManager = Provider.of<ImageManager>(context);
    File? image = imageManager.fullScreenImage;

    return IgnorePointer(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image == null ? null : Image.file(
                image,
                cacheWidth: MediaQuery.of(context).size.width.toInt(),
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}