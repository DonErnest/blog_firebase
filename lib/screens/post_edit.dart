import 'package:blog/models/post.dart';
import 'package:blog/providers/quote.dart';
import 'package:blog/widget/canvas.dart';
import 'package:blog/widget/quote_form/post_controller.dart';
import 'package:blog/widget/quote_form/post_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostEditScreen extends StatefulWidget {
  const PostEditScreen({super.key});

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  late String postId;
  Post? updatedPost;
  final postFormController = PostFormController();
  late PostsProvider postsProvider;
  bool updateInProgress = false;

  void editQuote() {
    if (postFormController.formKey.currentState!.validate()) {
      final postData = postFormController.getUpdatedPostData();
      updateInProgress = true;
      postsProvider.edit(postId, postData, context);
    }
  }

  @override
  void dispose() {
    Future.microtask(() {
      postsProvider.clearErrors();
    });
    super.dispose();
    postFormController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postsProvider = context.watch<PostsProvider>();
    postId = ModalRoute.of(context)!.settings.arguments as String;
    if (postsProvider.isFetchErrors) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                updateInProgress
                    ? Text('Something went wrong while updating')
                    : Text("Something went wrong while retrieving data"),
            action: SnackBarAction(
              label: 'Try again',
              onPressed: () {
                if (updateInProgress) {
                  final postData = postFormController.getUpdatedPostData();
                  postsProvider.edit(postId, postData, context);
                } else {
                  postsProvider.fetchOne(postId);
                }
              },
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      postId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<PostsProvider>().fetchOne(postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    postsProvider = context.watch<PostsProvider>();
    updatedPost = postsProvider.post;
    if (updatedPost != null) {
      postFormController.textController.text = updatedPost!.text;
      postFormController.titleController.text = updatedPost!.title;
      postFormController.createdOnController.text =
          updatedPost!.createdOn.toIso8601String();
    }
    return ScreenCanvas(
      widgets: [
        PostForm(controller: postFormController),
        TextButton(onPressed: editQuote, child: Text("Edit quote")),
      ],
      appBarTitleText: "Edit quote",
    );
  }
}
