import 'package:flutter/material.dart';
import 'package:flutter_jsonplaceholder/services/photo_service/photo_rest.dart';

import '../../models/photo.dart';

class PhotoViewModel extends ChangeNotifier {
  List<Photo> _photo = [];

  List<Photo> get photos => _photo;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  PhotoRest photo = PhotoRest();

  void getAllPhoto() async {
    _photo = await photo.fetchPhoto();
    _isLoading = false;
    notifyListeners();
  }
}
