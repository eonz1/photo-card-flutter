import 'package:flutter/material.dart';

import '../../../global/service/snack_bar_service.dart';
import '../service/account_service.dart';

class NicknameBottomSheetWidget extends StatefulWidget {
  const NicknameBottomSheetWidget({required this.nickname, super.key});

  final String nickname;

  @override
  State<NicknameBottomSheetWidget> createState() =>
      _NicknameBottomSheetWidgetState();
}

class _NicknameBottomSheetWidgetState extends State<NicknameBottomSheetWidget> {
  final _textEditingController = TextEditingController();
  final accountService = AccountService();
  final snackBarService = SnackBarService();

  @override
  void initState() {
    _textEditingController.text = widget.nickname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _textEditingController,
            maxLength: 12,
            decoration: const InputDecoration(
              labelText: "닉네임",
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final result = await accountService.saveNickname(
                    nickname: _textEditingController.text);

                if (mounted && result.nickname!.isNotEmpty) {
                  snackBarService.show("닉네임 변경이 완료되었어요.");
                  Navigator.pop(context, result.nickname);
                }
              },
              child: const Text("저장"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
