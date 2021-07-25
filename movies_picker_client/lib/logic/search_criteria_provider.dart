import 'package:flutter/material.dart';

import '../data/models/language.dart';
import '../data/models/location.dart';

class SearchCriteriaProvider with ChangeNotifier {
  String? title;
  Language? language;
  Location? location;

  void clear() {
    language = null;
    location = null;
    title = null;
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void changeLanguage(Language? newLanguage) {
    language = newLanguage;
    notifyListeners();
  }

  void changeLocation(Location? newLocation) {
    location = newLocation;
    notifyListeners();
  }
}
