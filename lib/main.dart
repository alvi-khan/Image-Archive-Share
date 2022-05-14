import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_archive_share/Body.dart';
import 'package:image_archive_share/ImageLoadingError.dart';
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
  List<String> images = [];
  bool loading = true;
  bool permissionDenied = false;

  void changeNotify(MethodCall call) {
    retrieveImages();
  }

  @override
  void initState() {
    super.initState();
    retrieveImages();
    PhotoManager.addChangeCallback(changeNotify);
    PhotoManager.startChangeNotify();
  }

  @override
  void dispose() {
    PhotoManager.stopChangeNotify();
    super.dispose();
  }

  void retrieveImages() async {
    List<AssetPathEntity> albums = [];
    try {
      albums = await PhotoManager.getAssetPathList();
    }
    catch(e) {
      setState(() => permissionDenied = true);
      print(e);
    }
    List<AssetEntity> images = [];
    for (var album in albums) {
      images.addAll(await album.getAssetListRange(start: 0, end: album.assetCount));
    }

    // recent images first
    images.sort((a, b) => b.createDateTime.compareTo(a.createDateTime));

    // multiple albums might have the same image
    // must ensure there are no duplicate
    Set<String> imageFilePaths = {};
    for (var image in images) {
      File? file = await image.file;
      if (file != null && !imageFilePaths.contains(file.path)) {
        imageFilePaths.add(file.path);
      }
    }
    setState(() {
      this.images = imageFilePaths.toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: permissionDenied ? const ImageLoadingError("Gallery access denied.") :
          loading ? const LoadingIndicator() : Body(images),
        ),
    );
  }
}
