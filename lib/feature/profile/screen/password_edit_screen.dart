import 'package:flutter/material.dart';

class PasswordEditScreen extends StatelessWidget {
  const PasswordEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("비밀번호 변경"),
          actions: [TextButton(onPressed: () {}, child: Text("완료"))]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "비밀번호"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "비밀번호 확인"),
            ),
          ],
        ),
      ),
    ));
  }
}
