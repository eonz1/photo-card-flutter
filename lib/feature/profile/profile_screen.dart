import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation/custom_bottom_navigation_bar.dart';
import '../account/screen/password_edit_notifier.dart';
import '../account/screen/password_edit_screen.dart';
import 'profile_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileService = ProfileService();

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CircleAvatar(
              radius: 25,
              // TODO: 프로필 사진 api 적용
              child: Icon(Icons.account_circle, size: 50),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                if (context.mounted) {
                  context.goNamed("account");
                }
              },
              child: const Text("내 정보 수정")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => PasswordEditNotifier(),
                      builder: (context, child) => const PasswordEditScreen(),
                    ),
                  ),
                );
              },
              child: const Text("비밀번호 변경")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () async {
                final result = await profileService.logout();

                if (result) {
                  final FlutterSecureStorage secureStorage =
                      FlutterSecureStorage();
                  await secureStorage.deleteAll();

                  if (!context.mounted) return;

                  context.goNamed("login");
                }
              },
              child: const Text("로그아웃")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                if (context.mounted) context.goNamed("withdraw");
              },
              child: const Text("탈퇴")),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    ));
  }
}
