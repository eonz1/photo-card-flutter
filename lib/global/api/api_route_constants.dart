import 'package:flutter/foundation.dart';

class ApiRouteConstants {
  static String getBaseUrl() {
    if (kDebugMode) {
      return "https://photocard.site/photocard";
    } else {
      // production mode
      return "https://photocard.site/photocard";
    }
  }

  static String basePath = "/api/v1";
}
