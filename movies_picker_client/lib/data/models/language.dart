import '../../shared/shared.dart';

enum Language {
  english,
  hindi,
}

extension LanguageExtension on Language {
  String get display => SharedFunctions.getEnumName(this);
}

abstract class LanguageParser {
  static Language parse(String s) {
    switch (s) {
      case 'ENGLISH':
        return Language.english;
      case 'HINDI':
        return Language.hindi;
      default:
        return Language.english;
    }
  }
}
