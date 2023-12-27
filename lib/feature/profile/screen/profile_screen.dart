import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/profile/screen/password_edit_screen.dart';
import 'package:photo_card_flutter/feature/profile/screen/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("프로필 화면")),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Text("프로필 사진"),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileEditScreen(),
                  ),
                );
              },
              child: const Text("내 정보 수정")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordEditScreen(),
                  ),
                );
              },
              child: const Text("비밀번호 변경")),
        ],
      ),
    ));
  }
}
