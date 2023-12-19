import 'package:flutter/foundation.dart';

class ApiRouteConstants {
  static String getBaseUrl() {
    if (kDebugMode) {
      return "https://9879-203-132-166-14.ngrok-free.app/photocard";
    } else {
      // production mode
      return "http://photocard.site:8080";
    }
  }

  static String basePath = "/api/v1";
}
