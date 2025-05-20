import 'package:blog/models/post.dart';
import 'package:blog/screens/post.dart';
import 'package:flutter/material.dart';

class QuoteTile extends StatelessWidget {
  final Post post;

  const QuoteTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final shortText =
        post.text.length >= 30 ? post.text.substring(0, 30) : post.text;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PostDetails(post: post)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: Text(post.title),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "$shortText...",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            trailing: Text("added on ${post.createdOnDisplay}"),
          ),
        ),
      ),
    );
  }
}
