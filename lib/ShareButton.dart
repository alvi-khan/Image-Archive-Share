import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key, required this.images, required this.selected}) : super(key: key);
  final List<File> images;
  final Set<int> selected;

  void share() async {
    if (selected.isEmpty) {
      return;
    }

    Directory directory = Directory.systemTemp;
    String zipFile = "/${DateTime.now().toString().replaceAll(":", "-")}.zip";
    var encoder = ZipFileEncoder();
    encoder.create(directory.path + zipFile, level: ZipFileEncoder.STORE);

    for (int i in selected) {
      File image = images[i];
      String filename = image.path.replaceAll(image.parent.path, "");
      encoder.addFile(image, filename, ZipFileEncoder.STORE);
    }

    encoder.close();
    await Share.shareFiles([directory.path + zipFile]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          onPressed: () => share(),
          child: const Text("Share", style: TextStyle(fontSize: 20),)
      ),
    );
  }
}