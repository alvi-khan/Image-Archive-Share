import 'dart:io';
import 'package:flutter/material.dart';

class ImageManager extends ChangeNotifier {
  List<String> images = [];
  Set<int> selected = {};
  File? fullScreenImage;

  void updateImages(List<String> images) {
    this.images = images;
    notifyListeners();
  }

  void toggleSelection(int index) {
    selected.add(index);
    notifyListeners();
  }

  void clearSelections() {
    selected.clear();
    notifyListeners();
  }

  void updateFullScreenImage(File? file) {
    fullScreenImage = file;
    notifyListeners();
  }
}