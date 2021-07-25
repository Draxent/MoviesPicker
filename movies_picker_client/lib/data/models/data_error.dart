import 'package:flutter/cupertino.dart';

@immutable
class DataError implements Exception {
  const DataError(this.message) : super();

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Error: $message';
}
