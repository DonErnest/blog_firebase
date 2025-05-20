import 'package:blog/models/post.dart';
import 'package:blog/providers/quote.dart';
import 'package:blog/widget/canvas.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatefulWidget {
  final Post post;

  const PostDetails({super.key, required this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widgets: [
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 40),
              Text(
                widget.post.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                widget.post.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,),
              ),
            ],
          ),
        ),
      ],
      appBarTitleText: widget.post.title,
    );
  }
}
