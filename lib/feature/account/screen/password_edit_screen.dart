import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../global/service/snack_bar_service.dart';
import '../service/password_edit_service.dart';
import 'password_edit_notifier.dart';

class PasswordEditScreen extends StatefulWidget {
  const PasswordEditScreen({super.key});

  @override
  State<PasswordEditScreen> createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  final passwordEditService = PasswordEditService();
  final snackBarService = SnackBarService();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PasswordEditNotifier>();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("비밀번호 변경"), actions: [
        TextButton(
            onPressed: () async {
              if (!viewModel.canPress) return;

              final result = await passwordEditService.changePassword(
                  currentPassword: viewModel.password.value,
                  newPassword: viewModel.newPassword.value);

              if (result.resultCode == 204) {
                snackBarService.show("비밀번호 변경이 완료되었어요.");

                if (context.mounted) context.pop();
              }
            },
            child: const Text("완료"))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                viewModel.changePassword(value);
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "비밀번호",
                  hintText: "현재 비밀번호",
                  errorText: viewModel.password.error),
            ),
            TextFormField(
              onChanged: (value) {
                viewModel.changeNewPassword(value);
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "새로운 비밀번호",
                  hintText: "영문 대/소문자, 숫자, 특수문자 조합 8-16자",
                  errorText: viewModel.newPassword.error),
            ),
            TextFormField(
              onChanged: (value) {
                viewModel.changeReEnterPassword(value);
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "새로운 비밀번호 확인",
                  errorText: viewModel.reEnterPassword.error),
            ),
          ],
        ),
      ),
    ));
  }
}
