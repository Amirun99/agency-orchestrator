import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/screens/photo/photo_viewModel.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  PhotoViewModel viewModel = PhotoViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getAllPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoViewModel>(
      lazy: true,
      create: (context) => viewModel,
      child: Consumer<PhotoViewModel>(builder: (context, value, child) {
        if (viewModel.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return ListView.builder(
            itemCount: value.photos.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ExpansionTile(
                      leading: Image.network(value.photos[index].thumbnailUrl!),
                      title: Text(value.photos[index].title!),
                      children: [
                        Text('Album ID: ${value.photos[index].albumId}}'),
                        const SizedBox(height: 10),
                        Image.network(
                          value.photos[index].url!,
                          frameBuilder: (BuildContext context, Widget child,
                                  frame, bool wasSynchronouslyLoaded) =>
                              wasSynchronouslyLoaded
                                  ? child
                                  : AnimatedOpacity(
                                      child: child,
                                      opacity: frame == null ? 0 : 1,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeOut,
                                    ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ));
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
