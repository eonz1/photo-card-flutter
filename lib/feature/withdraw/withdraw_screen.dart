import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_card_flutter/feature/withdraw/api/withdraw_request.dart';

import 'withdraw_service.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    final service = WithdrawService();
    final textEditingController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("회원탈퇴"),
      ),
      body: Column(
        children: [
          TextFormField(
              controller: textEditingController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "비밀번호",
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () async {
                final request =
                    WithdrawRequest(password: textEditingController.text);

                final response = await service.withdraw(request);

                if (context.mounted && response) context.goNamed("login");
              },
              child: const Text("탈퇴")),
        ],
      ),
    ));
  }
}
