import 'package:flutter/material.dart';
import 'package:image_archive_share/ImageManager.dart';
import 'package:provider/provider.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
          onPressed: () => Provider.of<ImageManager>(context, listen: false).clearSelections(),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.clear_rounded),
                SizedBox(width: 10),
                Text("Clear", style: TextStyle(fontSize: 20))
              ]
          )
      ),
    );
  }
}