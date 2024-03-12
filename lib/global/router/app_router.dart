import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_card_flutter/feature/withdraw/withdraw_screen.dart';

import '../../feature/account/screen/account_edit_screen.dart';
import '../../feature/profile/profile_screen.dart';
import '../../feature/home/screen/dev_pages_screen.dart';
import '../../feature/home/screen/home_screen.dart';
import '../../feature/login/screen/login_screen.dart';
import '../../feature/sign_up/screen/sign_up_screen.dart';
import '../service/global_keys.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: false,
    // refreshListenable: TODO,
    navigatorKey: navigatorKey,
    initialLocation: getInitialLocation(),
    routes: [
      GoRoute(
        name: "home",
        path: "/",
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const HomeScreen(),
        ),
        routes: [
          GoRoute(
              name: "profile",
              path: "profile",
              pageBuilder: (context, state) => buildNoTransitionPageWithState(
                    state: state,
                    child: const ProfileScreen(),
                  ),
              routes: [
                GoRoute(
                  name: "account",
                  path: "account",
                  pageBuilder: (context, state) =>
                      buildNoTransitionPageWithState(
                    state: state,
                    child: const AccountEditScreen(),
                  ),
                ),
              ]),
          GoRoute(
            name: "withdraw",
            path: "withdraw",
            pageBuilder: (context, state) => buildNoTransitionPageWithState(
              state: state,
              child: const WithdrawScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        name: "login",
        path: "/login",
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: "sign-up",
        path: "/sign-up",
        pageBuilder: (context, state) => buildNoTransitionPageWithState(
          state: state,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: "dev-pages",
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
