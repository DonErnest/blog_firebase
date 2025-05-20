import 'package:blog/app_routes.dart';
import 'package:blog/providers/quote.dart';
import 'package:blog/widget/canvas.dart';
import 'package:blog/widget/quote_form/post_controller.dart';
import 'package:blog/widget/quote_form/post_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  final quoteFormController = PostFormController();
  late PostsProvider quotesProvider;

  void addQuote() {
    if (quoteFormController.formKey.currentState!.validate()) {
      final quoteData = quoteFormController.getNewPostData();
      quotesProvider.addNew(quoteData);
      Navigator.of(context).pushReplacementNamed(AppRoutes.posts, arguments: null);
    }
  }

  @override
  void dispose() {
    super.dispose();
    quoteFormController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    quotesProvider = context.watch<PostsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widgets: [
        PostForm(controller: quoteFormController),
        TextButton(onPressed: addQuote, child: Text("Add post")),
      ],
      appBarTitleText: "Add post",
    );
  }
}
