import 'package:blog/models/post.dart';
import 'package:blog/services/posts.dart';
import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isFetching = false;
  bool _isFetchErrors = false;


  List<Post> get posts => _posts;
  bool get isFetching => _isFetching;
  bool get isFetchErrors => _isFetchErrors;

  void clearErrors() {
    _isFetchErrors = false;
    notifyListeners();
  }

  void fetchList() async {
    try {
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPosts = await getPosts();
      if (fetchedPosts.isEmpty) {
        _posts = [];
        return;
      }
      _posts = fetchedPosts;
    } catch (e) {
      print(e);
      _isFetchErrors = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<UpdatePost?> fetchOne(String postId) async {
    try {
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPost = await getPost(postId);
      if (fetchedPost == null) {
        return fetchedPost;
      }
      _isFetching = false;
      return fetchedPost;
    } catch (e) {
      _isFetchErrors = true;
      _isFetching = false;
      return null;
    }
  }

  void addNew(AddPost postData) async {
    try {
      await postPost(postData);
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPosts = await getPosts();
      if (fetchedPosts.isEmpty) {
        _posts = [];
        return;
      }
      _posts = fetchedPosts;
    } catch (e) {
      _isFetchErrors = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void edit(String id, UpdatePost postData) async {
    try {
      await updatePost(id, postData);
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPosts = await getPosts();
      if (fetchedPosts.isEmpty) {
        _posts = [];
        return;
      }
      _posts = fetchedPosts;
    } catch (e) {
      _isFetchErrors = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void remove (String id) async {
    try {
      await deletePost(id);
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPosts = await getPosts();
      if (fetchedPosts.isEmpty) {
        _posts = [];
        return;
      }
      _posts = fetchedPosts;
    } catch (e) {
      _isFetchErrors = true;
    } finally {
    _isFetching = false;
    notifyListeners();
    }
  }

}