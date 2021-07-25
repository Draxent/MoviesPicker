import '../../shared/shared.dart';

enum Location {
  bangalore,
  chennai,
  delhi,
  pune,
}

extension LocationExtension on Location {
  String get display => SharedFunctions.getEnumName(this);
}

abstract class LocationParser {
  static Location parse(String s) {
    switch (s) {
      case 'BANGALORE':
        return Location.bangalore;
      case 'CHENNAI':
        return Location.chennai;
      case 'DELHI':
        return Location.delhi;
      case 'PUNE':
      default:
        return Location.pune;
    }
  }
}
