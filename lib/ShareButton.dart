import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  ShareButton({Key? key}) : super(key: key);
  late final BuildContext context;
  late ImageManager imageManager;

  void error() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "No images selected.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16)
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.all(15),
          duration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 80,
            right: 80,
          ),
        )
    );
  }

  void share() async {
    if (imageManager.selected.isEmpty) {
      error();
      return;
    }

    Directory directory = Directory.systemTemp;
    String zipFile = "/${DateTime.now().toString().replaceAll(":", "-")}.zip";
    var encoder = ZipFileEncoder();
    encoder.create(directory.path + zipFile, level: ZipFileEncoder.STORE);

    for (int i in imageManager.selected) {
      File image = File(imageManager.images[i]);
      String filename = image.path.replaceAll(image.parent.path, "");
      encoder.addFile(image, filename, ZipFileEncoder.STORE);
    }

    encoder.close();
    ShareResult result = await Share.shareFilesWithResult([directory.path + zipFile]);
    if (result.status == ShareResultStatus.success) imageManager.clearSelections();
  }

  @override
  Widget build(BuildContext context) {
    imageManager = Provider.of<ImageManager>(context);
    this.context = context;

    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              )
          ),
          onPressed: () => share(),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.share),
                SizedBox(width: 10),
                Text("Share", style: TextStyle(fontSize: 20))
              ]
          )
      ),
    );
  }
}