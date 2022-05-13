import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_archive_share/Body.dart';
import 'package:image_archive_share/LoadingIndicator.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    retrieveImages();
  }

  void retrieveImages() async {
    final albums = await PhotoManager.getAssetPathList();
    List<AssetEntity> images = [];
    for (var album in albums) {
      images.addAll(await album.getAssetListRange(start: 0, end: album.assetCount));
    }

    // recent images first
    images.sort((a, b) => a.createDateTime.compareTo(b.createDateTime));

    // multiple albums might have the same image
    // must ensure there are no duplicate
    Set<String> imageFilePaths = {};
    List<File> imageFiles = [];
    for (var image in images) {
      File? file = await image.file;
      if (file != null && !imageFilePaths.contains(file.path)) {
        imageFilePaths.add(file.path);
        imageFiles.add(file);
      }
    }
    setState(() => this.images = imageFiles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: images.isEmpty ? const LoadingIndicator() : Body(images + images + images),
        ),
    );
  }
}
