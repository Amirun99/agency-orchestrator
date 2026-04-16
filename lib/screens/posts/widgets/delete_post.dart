import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/posts/posts_viewModel.dart';

deletePost(BuildContext context, PostViewModel viewModel, int index) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            elevation: 3,
            backgroundColor: Colors.white,
            title: Text('Are You Sure You Want To Delete Thid Post?'),
            actions: [
              GestureDetector(
                onTap: () {
                  viewModel.deletePost(viewModel.post.id ?? index);
                  viewModel.posts.removeAt(index);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              )
            ],
          ));
}
