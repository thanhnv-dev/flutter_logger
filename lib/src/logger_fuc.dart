import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_logger/src/ansi_color_enum.dart';
import 'package:flutter_logger/src/logger_string.dart';

class MyLogger {
  static String _colorize(String message, AnsiColor color) {
    return '$color$message${AnsiColor.reset}';
  }

  static void error(dynamic message) {
    developer.log(
      _colorize(message, AnsiColor.highIntensityRed),
    );
  }

  static void debugLog(dynamic message) {
    debugPrint(_colorize(message, AnsiColor.highIntensityPurple));
  }

  static String _uriLog(String uri) {
    return _colorize(
      "${LoggerString.path}: $uri",
      AnsiColor.highIntensityCyan,
    );
  }

  static void apiError({
    required int? statusCode,
    required String uri,
    required dynamic data,
  }) {
    String statusLog = _colorize(
      "${LoggerString.error} [$statusCode] 🧨",
      AnsiColor.highIntensityRed,
    );

    String uriLog = _uriLog(uri);

    String dataLog = _colorize(
      "${LoggerString.data}: $data",
      AnsiColor.highIntensityRed,
    );
    String dataJsonLog = _colorize(
      "${LoggerString.data}: ${jsonEncode(data)}",
      AnsiColor.highIntensityRed,
    );

    String time = _colorize(
      "${DateTime.now()}",
      AnsiColor.highIntensityPurple,
    );

    if (data != null) {
      try {
        developer.log(
          "$time \n$statusLog \n$uriLog \n$dataJsonLog",
        );
      } catch (e) {
        developer.log(
          "$time \n$statusLog \n$uriLog \n$dataLog",
        );
      }
    } else {
      developer.log(
        "$time \n$statusLog \n$uriLog",
      );
    }
  }

  static void apiRequest({
    required String method,
    required String uri,
    required dynamic token,
    dynamic data,
  }) {
    String uriLog = _uriLog(uri);

    String methodLog = _colorize(
      "${LoggerString.request}: [$method] 🚀",
      AnsiColor.highIntensityYellow,
    );
    String tokenLog = _colorize(
      "${LoggerString.token}: $token",
      AnsiColor.highIntensityYellow,
    );
    String dataLog = _colorize(
      "${LoggerString.data}: $data",
      AnsiColor.highIntensityYellow,
    );

    String time = _colorize(
      "${DateTime.now()}",
      AnsiColor.highIntensityPurple,
    );

    if (method == 'GET') {
      developer.log(
        "$time \n$methodLog \n$uriLog \n$tokenLog",
      );
    } else {
      try {
        String dataJsonLog = _colorize(
          "${LoggerString.data}: ${jsonEncode(data)}",
          AnsiColor.highIntensityYellow,
        );
        developer.log(
          "$time \n$methodLog \n$uriLog \n$tokenLog \n$dataJsonLog",
        );
      } catch (e) {
        developer.log(
          "$time \n$methodLog \n$uriLog \n$tokenLog \n$dataLog",
        );
      }
    }
  }

  static void apiResponse({
    required int? statusCode,
    required String uri,
    required dynamic data,
  }) {
    String uriLog = _uriLog(uri);

    String statusLog = _colorize(
      "${LoggerString.response}: [$statusCode] 📥",
      AnsiColor.highIntensityGreen,
    );

    String dataLog = _colorize(
      "${LoggerString.data}: $data",
      AnsiColor.highIntensityGreen,
    );

    String time = _colorize(
      "${DateTime.now()}",
      AnsiColor.highIntensityPurple,
    );

    developer.log(
      "$time \n$statusLog \n$uriLog  \n$dataLog",
    );
  }
}
