import 'package:flutter/material.dart';

import '../../../common/validation/validation_format.dart';

class EmailBottomSheetWidget extends StatefulWidget {
  const EmailBottomSheetWidget({super.key});

  @override
  State<EmailBottomSheetWidget> createState() => _EmailBottomSheetWidgetState();
}

class _EmailBottomSheetWidgetState extends State<EmailBottomSheetWidget> {
  final _emailTextEditingController = TextEditingController();
  final _verifyCodeTextEditingController = TextEditingController();
  final validationFormat = ValidationFormat();

  String? errorText;

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _verifyCodeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _emailTextEditingController,
                decoration:
                    InputDecoration(labelText: "이메일", errorText: errorText),
                onChanged: (value) {
                  final validFormat = validationFormat.isEmailFormat(value);

                  if (validFormat == false) {
                    setState(() {
                      errorText = "이메일 주소를 정확히 입력해주세요.";
                    });
                  } else {
                    setState(() {
                      errorText = null;
                    });
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  // TODO: 이메일 인증코드 받기 api 호출
                },
                child: const Text("인증코드 전송"))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _verifyCodeTextEditingController,
                decoration: const InputDecoration(
                  labelText: "인증 코드",
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  // TODO: 이메일 인증 api 호출
                  Navigator.pop(context, _emailTextEditingController.text);
                },
                child: const Text("인증하기"))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _emailTextEditingController.text);
            },
            child: const Text("저장"))
      ],
    );
  }
}
