import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';


class PostFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final textController = TextEditingController();
  final titleController = TextEditingController();
  final createdOnController = TextEditingController();

  void dispose() {
    textController.dispose();
    titleController.dispose();
    createdOnController.dispose();
  }

  AddPost getNewPostData() {
    final newPost = AddPost(
      text: textController.text,
      title: titleController.text,
    );
    return newPost;
  }

  UpdatePost getUpdatedQuoteData() {
    final editedQuoteData = UpdatePost(
      text: textController.text,
      title: titleController.text,
      createdOn: createdOnController.text,
    );
    return editedQuoteData;
  }
}
