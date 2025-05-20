import 'package:blog/models/post.dart';
import 'package:blog/services/posts.dart';
import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];

  bool _isFetching = false;
  bool _isFetchErrors = false;

  bool _isDeleting = false;
  bool _isDeleteErrors = false;

  Post? _post;


  List<Post> get posts => _posts;
  Post? get post => _post;

  bool get isFetching => _isFetching;
  bool get isFetchErrors => _isFetchErrors;

  bool get isDeleting => _isDeleting;
  bool get isDeleteErrors => _isDeleteErrors;

  void clearErrors() {
    _isFetchErrors = false;
    _isDeleteErrors = false;
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
      _isFetchErrors = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

 void fetchOne(String postId) async {
    try {
      _isFetching = true;
      _isFetchErrors = false;
      final fetchedPost = await getPost(postId);
      if (fetchedPost == null) {
        _post = null;
      }
      _post = fetchedPost;
    } catch (e) {
      _isFetchErrors = true;
      return null;
    } finally {
      _isFetching = false;
      notifyListeners();
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

  void edit(String id, UpdatePost postData, BuildContext context) async {
    try {
      // I don't know whether it is the best practice, but it is the most simple one
      _posts = [];
      _post = null;
      notifyListeners();
      _isFetching = true;
      _isFetchErrors = false;
      await updatePost(id, postData);
      final fetchedPosts = await getPosts();
      if (fetchedPosts.isEmpty) {
        _posts = [];
        return;
      }
      _posts = fetchedPosts;
      Navigator.of(context).pop();
    } catch (e) {
      _isFetchErrors = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  void remove (String id) async {
    try {
      _isDeleting = true;
      _isDeleteErrors = false;
      await deletePost(id);
    } catch (e) {
      _isDeleteErrors = true;
      _isDeleting = false;
      notifyListeners();
      return;
    }
    _isDeleting = false;
    notifyListeners();
    fetchList();
  }
}