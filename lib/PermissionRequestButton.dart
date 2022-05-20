import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestButton extends StatelessWidget {
  const PermissionRequestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        onPressed: () => openAppSettings(),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.perm_media_rounded),
              SizedBox(width: 10),
              Text("Grant Access", style: TextStyle(fontSize: 20))
            ]
        )
    );
  }
}