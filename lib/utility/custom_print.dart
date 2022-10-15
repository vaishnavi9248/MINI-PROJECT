import 'package:flutter/foundation.dart';

void customPrint(dynamic message) {
  if (kDebugMode) {
    print(message.toString());
  }
}
