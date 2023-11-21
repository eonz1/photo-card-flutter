import 'package:flutter/foundation.dart';

class ApiRouteConstants {
  static String getBaseUrl() {
    if (kDebugMode) {
      return "http://photocard.site:8080";
    } else {
      // production mode
      return "http://photocard.site:8080";
    }
  }

  static String basePath = "/api/v1";
}
