import 'package:flutter/material.dart';

class NicknameBottomSheetWidget extends StatefulWidget {
  const NicknameBottomSheetWidget({required this.nickname, super.key});

  final String nickname;

  @override
  State<NicknameBottomSheetWidget> createState() =>
      _NicknameBottomSheetWidgetState();
}

class _NicknameBottomSheetWidgetState extends State<NicknameBottomSheetWidget> {
  final _textEditingController = TextEditingController();

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
              onPressed: () {
                // TODO: 닉네임 변경 api 호출
                Navigator.pop(context, _textEditingController.text);
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
