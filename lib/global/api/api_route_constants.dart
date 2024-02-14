import 'package:flutter/foundation.dart';

class ApiRouteConstants {
  static String getBaseUrl() {
    if (kDebugMode) {
      return "http://129.154.62.23:8080/photocard";
    } else {
      // production mode
      return "http://photocard.site:8080";
    }
  }

  static String basePath = "/api/v1";
}
