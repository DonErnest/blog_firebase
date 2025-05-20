import 'package:blog/app_routes.dart';
import 'package:blog/models/post.dart';
import 'package:blog/providers/quote.dart';
import 'package:blog/widget/canvas.dart';
import 'package:blog/widget/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late List<Post> posts;
  late PostsProvider postsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      context.read<PostsProvider>().fetchList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postsProvider = context.watch<PostsProvider>();
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
    Widget body;

    if (postsProvider.isFetching) {
      body = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Loading'),
          SizedBox(width: 8),
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      );
    } else if (postsProvider.isFetchErrors) {
      body = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Something went wrong'),
          SizedBox(width: 8),
          Icon(Icons.error_outline),
          TextButton(
            onPressed: () => postsProvider.fetchList(),
            child: Text("Try again"),
          ),
        ],
      );
    } else if (postsProvider.posts.isEmpty) {
      body = Text("No posts available");
    } else {
      body = Expanded(
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            final post = postsProvider.posts[idx];
            return PostTile(post: post);
          },
          itemCount: postsProvider.posts.length,
        ),
      );
    }

    return ScreenCanvas(
      widgets: [body],
      appBarTitleText: "Posts",
      appBarActions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.addPost),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
