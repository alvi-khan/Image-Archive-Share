import 'dart:io';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery(this.images, {Key? key}) : super(key: key);
  final List<File> images;

  @override
  State<StatefulWidget> createState() => _Gallery();
}

class _Gallery extends State<Gallery> {

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
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(widget.images[index])
                ),
              );
            }
        ),
      ),
    );
  }
}