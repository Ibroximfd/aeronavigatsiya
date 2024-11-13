import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifier = ChangeNotifierProvider((ref) => LoginController());

class LoginController with ChangeNotifier {}
