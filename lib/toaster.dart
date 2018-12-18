import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

enum Duration {
  SHORT,
  LONG
}


class Toaster {
  static const MethodChannel _channel =
      const MethodChannel('toaster');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future toast({Duration duration, @required String message}) async {
    int d = 0;
    if(duration == Duration.LONG) {
      d = 1;
    } else {
      d = 0;
    }

    final Map<String, dynamic> params = <String, dynamic> {
      'message' : message,
      'duration': d
    };

    await _channel.invokeMethod('toast', params);

  }
}
