import 'package:flutter/material.dart';
import 'package:image_archive_share/PermissionRequestButton.dart';

class ImageLoadingError extends StatelessWidget {
  const ImageLoadingError(this.msg, {Key? key, this.permissionsRequired = false}) : super(key: key);
  final String msg;
  final bool permissionsRequired;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported_rounded, size: 100),
          const SizedBox(height: 20),
          Text(msg, style: const TextStyle(fontSize: 25)),
          const SizedBox(height: 20),
          if (permissionsRequired)  const PermissionRequestButton(),
        ],
      ),
    );
  }
}