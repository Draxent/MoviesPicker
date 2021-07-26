import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

abstract class SharedConsts {
  static const appName = 'Movies Picker';
  static const responseOk = 200;
  static const responseInternalServerError = 500;
  static const authorityURL = '10.0.2.2:8080';
  static const baseURL = '/api/v1';
}

abstract class SharedSizes {
  static const poster = Size(300, 444);
  static const posterRatio = 300 / 444;
  static const stills = Size(150, 150);
}

abstract class SharedSymbol {
  static const emptyStr = '';
  static const dot = '.';
  static const commaSpace = ', ';
}

abstract class SharedWidgets {
  static const circularProgressIndicator =
      Center(child: CircularProgressIndicator());
  static const emptyBox = SizedBox();
  static const hSpaceSmall = SizedBox(width: 10);
  static const hSpace = SizedBox(width: 30);
  static const vSpace = SizedBox(height: 30);
}

abstract class SharedImages {
  static const imagePath = 'assets/images';
  static const comingSoon = '$imagePath/coming_soon.png';
}

abstract class SharedColors {}

abstract class ArgumentKeys {}

abstract class SharedFunctions {
  static Size getPageSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    final height = size.height - appBarHeight;
    return Size(size.width, height);
  }

  static String getEnumName(dynamic x) =>
      x.toString().split(SharedSymbol.dot).last.toUpperCase();
}

extension TextStyleExtension on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}
