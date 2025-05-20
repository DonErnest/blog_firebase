
import 'package:blog/helpers/request.dart';
import 'package:blog/models/post.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final postsDatabaseUri = dotenv.env['BASE_QUOTES_URL'];


Future<List<Post>> getPosts() async {
  var uri = "${postsDatabaseUri}posts.json";
  final response = await request(uri);

  if (response == null) {
    return [];
  }

  List<Post> posts = [];
  for (final key in response.keys) {
    final Map<String, dynamic> quoteJson = {...response[key], 'id': key};
    final quote = Post.fromJson(quoteJson);
    posts.add(quote);
  }
  return posts;
}

Future<UpdatePost?> getPost(String postId) async {
  final uri = '${postsDatabaseUri}posts/$postId.json';
  final response = await request(uri);

  if (response == null) {
    return null;
  }

  final Map<String, dynamic> postJson = {...response};
  final postData = UpdatePost.fromJson(postJson);
  return postData;
}


Future<void> postPost(AddPost postData) async {
  final uri = "${postsDatabaseUri}posts.json";
  await request(uri, body: postData.toJson(), method: "POST");
}

Future<void> updatePost(String id, UpdatePost postData) async {
  final uri = '${postsDatabaseUri}posts/$id.json';
  await request(uri, body: postData.toJson(), method: "PUT");
}

Future<void> deletePost(String id) async  {
  final uri = '${postsDatabaseUri}posts/$id.json';
  await request(uri, method: "DELETE");
}
