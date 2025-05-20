
import 'package:blog/providers/quote.dart';
import 'package:blog/screens/not_found.dart';
import 'package:blog/screens/post_add.dart';
import 'package:blog/screens/quote_edit.dart';
import 'package:blog/screens/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (ctx) => PostsProvider()),
      ],
        child: MaterialApp(
          routes: {
            AppRoutes.posts: (ctx) => PostsScreen(),
            AppRoutes.addPost: (ctx) => PostAddScreen(),
            // AppRoutes.editQuote: (ctx) => QuoteEditScreen(),
          },
          initialRoute: AppRoutes.posts,
          title: "The most useful blog of our timeline",
          onUnknownRoute:
              (s) => MaterialPageRoute(builder: (ctx) => NotFoundScreen()),
        ),
      )

  );
}
