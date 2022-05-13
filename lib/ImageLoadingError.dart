import 'package:flutter/material.dart';

class ImageLoadingError extends StatelessWidget {
  const ImageLoadingError(this.msg, {Key? key}) : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported_rounded, size: 100),
          const SizedBox(height: 20),
          Text(msg, style: const TextStyle(fontSize: 25))
        ],
      ),
    );
  }
}