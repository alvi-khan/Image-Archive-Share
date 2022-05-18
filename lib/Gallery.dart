import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageContainer.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:provider/provider.dart';

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);
  late ImageManager imageManager;

  @override
  Widget build(BuildContext context) {
    imageManager = Provider.of<ImageManager>(context);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: imageManager.images.length,
        itemBuilder: (context, index) {
          return Center(
            child: ImageContainer(index),
          );
        }
    );
  }

}