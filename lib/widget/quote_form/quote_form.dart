import 'package:blog/widget/quote_form/post_controller.dart';
import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  final PostFormController controller;

  const PostForm({super.key, required this.controller});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Add title")),
              controller: widget.controller.titleController,
              maxLines: 1,
              maxLength: 50,
              validator: (value) {
                if (value == null) {
                  return "Please, add title!";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text("Add text")),
              controller: widget.controller.textController,
              maxLines: 5,
              maxLength: 300,
              validator: (value) {
                if (value == null) {
                  return "Please, add text!";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
