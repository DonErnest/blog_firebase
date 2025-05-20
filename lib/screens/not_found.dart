import 'package:blog/widget/canvas.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      appBarTitleText: "Not Found",
      widgets: [
        Text("No route has been found (as backend developer, this is 404)"),
      ],
    );
  }
}
