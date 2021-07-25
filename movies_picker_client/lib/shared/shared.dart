import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

abstract class SharedConsts {
  static const appName = 'Movies Picker';
  static const responseOk = 200;
  static const responseInternalServerError = 500;
  static const authorityURL = 'localhost:8080';
  static const baseURL = '/api/v1';
}

abstract class SharedSizes {}

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

abstract class SharedImages {}

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
