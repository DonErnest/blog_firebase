import 'package:blog/app_routes.dart';
import 'package:blog/models/post.dart';
import 'package:blog/providers/quote.dart';
import 'package:blog/screens/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PostTile extends StatefulWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late PostsProvider postsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postsProvider = context.watch<PostsProvider>();
    if (postsProvider.isDeleteErrors) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong while deleting data"),
            action: SnackBarAction(
              label: 'Try again',
              onPressed: () {
                postsProvider.remove(widget.post.id);
              },
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    Future.microtask(() {
      postsProvider.clearErrors();
    });
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shortText =
        widget.post.text.length >= 30 ? widget.post.text.substring(0, 30) : widget.post.text;
    return GestureDetector(
      onTap: () {
        if (!postsProvider.isDeleting) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PostDetails(post: widget.post)),
          );
        }
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (ctx) => postsProvider.remove(widget.post.id),
              icon: Icons.delete,
              backgroundColor: theme.colorScheme.error.withAlpha(220),
              label: 'Delete',
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed:
                  (ctx) => Navigator.of(
                context,
              ).pushNamed(AppRoutes.editPost, arguments: widget.post.id),
              icon: Icons.edit,
              backgroundColor: theme.colorScheme.secondary.withAlpha(220),
              label: 'Edit',
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(widget.post.title),
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
              trailing: Text("added on ${widget.post.createdOnDisplay}"),
            ),
          ),
        ),
      ),
    );
  }
}
