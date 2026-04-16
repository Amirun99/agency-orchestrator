import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/posts/posts_viewModel.dart';
import 'package:flutter_jsonplaceholder/screens/posts/widgets/add_post_dialog.dart';
import 'package:flutter_jsonplaceholder/screens/posts/widgets/delete_post.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> with TickerProviderStateMixin {
  final PostViewModel viewModel = PostViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostViewModel>(
      create: (context) => viewModel,
      child: Consumer<PostViewModel>(builder: (context, value, child) {
        if (viewModel.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(children: [
          ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onLongPress: () {
                  deletePost(context, viewModel, index);
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: ExpansionTile(
                      leading: Text('ID: ${value.posts[index].id}'),
                      title: Text(value.posts[index].title!),
                      children: [
                        Text('UserID: ${value.posts[index].userId}'),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            value.posts[index].body!,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            itemCount: value.posts.length,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    addNewPost(context, viewModel);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]);
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
