import 'package:flutter/cupertino.dart';
import 'package:flutter_jsonplaceholder/services/posts_service/posts_rest.dart';

import '../../models/Post.dart';

class PostViewModel extends ChangeNotifier {
  List<Post> _postsList = []; // state
  bool _isLoading = true;
  String _error = '';
  Post _post = Post();

  List<Post> get posts =>
      _postsList; //each state should have a getter to use outside class
  Post get post => _post;
  String get error => _error;

  bool get isLoading => _isLoading;

  PostsRest service = PostsRest();

  void getAllPosts() async {
    _postsList = await service.fetchStores().catchError((err) => _error = err);
    _isLoading = false;
    notifyListeners();
  }

  void addPost(Post post) async {
    _isLoading = true;
    await service.createPost(post).then((value) => print('Created new Post'));

    _isLoading = false;
    notifyListeners();
  }

  void deletePost(int id) async {
    await service.deletePost(id);
    notifyListeners();
  }

  void setPost(Post post) {
    _post = post;
    notifyListeners();
  }
}
