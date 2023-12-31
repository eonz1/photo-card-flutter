import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_card_flutter/feature/home/screen/dev_pages_screen.dart';
import 'package:photo_card_flutter/feature/login/screen/login_screen.dart';

import '../../feature/home/screen/home_screen.dart';
import '../service/global_keys.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: false,
    // refreshListenable: TODO,
    navigatorKey: navigatorKey,
    initialLocation: getInitialLocation(),
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const HomeScreen(),
        ),
        routes: [],
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: "/dev-pages",
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const DevPagesScreen(),
        ),
      ),
    ],
    // TODO: 에러페이지 만들기
    // errorBuilder: (context, state) {
    //   return ErrorScreen();
    // },
  );
}

Page<dynamic> buildNoTransitionPageWithState({
  required GoRouterState state,
  required Widget child,
}) {
  return NoTransitionPage(
    key: state.pageKey,
    name: state.name,
    child: child,
  );
}

String getInitialLocation() {
  if (kDebugMode) {
    return '/dev-pages';
  }

  return '/login';
}
