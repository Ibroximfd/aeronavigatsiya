import 'package:flutter/material.dart';

@immutable
sealed class NetworkConstants {
  const NetworkConstants._();

  static const String library = 'library';
  static const String aktLibrary = 'aktLibrary';
  static const String radioLibrary = 'radioLibrary';
}
