import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _nicknameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();

  @override
  void dispose() {
    _nicknameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("내 정보 수정"),
          actions: [TextButton(onPressed: () {}, child: Text("완료"))]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Text("프로필 사진"),
            ),
            TextFormField(
              controller: _nicknameTextEditingController,
              decoration: const InputDecoration(labelText: "닉네임"),
            ),
            TextFormField(
              controller: _emailTextEditingController,
              decoration: const InputDecoration(labelText: "이메일"),
            ),
          ],
        ),
      ),
    ));
  }
}
