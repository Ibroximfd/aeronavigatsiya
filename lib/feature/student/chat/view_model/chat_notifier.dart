import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatNotifier = ChangeNotifierProvider((ref) => ChatController());

class ChatController with ChangeNotifier {}
