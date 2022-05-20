import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({Key? key, required this.image}) : super(key: key);
  final File? image;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin{
  late Listenable animation;
  late AnimationController controller;
  Image? image;
  bool cover = false;

  void updateImage() {
    if (widget.image != null) {
      setState(() {
        cover = true;
        image = Image.file(
          widget.image!,
          cacheWidth: MediaQuery.of(context).size.width.toInt(),
          width: MediaQuery.of(context).size.width,
        );
      });
      controller.forward();
    }
    else {
      setState(() => cover = false);
      controller.reverse().whenComplete(() {
        setState(() => image = null);
      });
    }
  }

  @override
  void didUpdateWidget(covariant FullScreenImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateImage();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
    );
    animation = controller;
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: controller,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image
        ),
        builder: (context, child) {
          return Stack(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: cover ? 1 : 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black87,
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * controller.value,
                    child: child,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}