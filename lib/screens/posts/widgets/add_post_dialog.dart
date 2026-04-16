import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/posts/posts_viewModel.dart';

import '../../../models/Post.dart';

addNewPost(BuildContext context, PostViewModel viewModel) {
  return showDialog(
      context: context,
      builder: (context) {
        String postTitle = '';
        String postContent = '';
        int id = 1;
        return AlertDialog(
          elevation: 3,
          title: Text('Add New Post'),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 1.2,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (value) {
                        postTitle = value;
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Post Title',
                      ),
                      controller: TextEditingController(text: ''),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    child: TextField(
                      onChanged: (value) {
                        postContent = value;
                      },
                      maxLines: 6,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Post Content',
                      ),
                      controller: TextEditingController(text: ''),
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Post newPost = Post(
                  id: viewModel.posts.length + 1,
                  userId: 2,
                  title: postTitle,
                  body: postContent,
                );
                if (postTitle.isNotEmpty && postContent.isNotEmpty) {
                  viewModel.addPost(newPost);
                  viewModel.posts.add(newPost);
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'Confirm',
              ),
            )
          ],
        );
      });
}
