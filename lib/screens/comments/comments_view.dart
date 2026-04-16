import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/comments/comments_viewModel.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final CommentViewModel viewModel = CommentViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getAllComments();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentViewModel>(
      lazy: true,
      create: (context) => viewModel,
      child: Consumer<CommentViewModel>(builder: (context, value, child) {
        if (viewModel.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return ListView.builder(
          itemCount: value.comments.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              margin: const EdgeInsets.only(bottom: 5),
              child: ExpansionTile(
                leading: Text('ID: ${value.comments[index].id}'),
                title: Text(value.comments[index].name!),
                children: [
                  Text('Email: ${value.comments[index].email}'),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(value.comments[index].body!),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
