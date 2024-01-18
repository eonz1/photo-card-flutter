import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/account/service/account_service.dart';
import 'package:photo_card_flutter/feature/verify/api/verify_email_request.dart';

import '../../../common/validation/validation_format.dart';
import '../../../global/logger.dart';
import '../../../global/service/snack_bar_service.dart';

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
    final accountService = AccountService();
    final snackBarService = SnackBarService();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
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
                  onPressed: () async {
                    final request = VerifyEmailRequest(
                        userEmail: _emailTextEditingController.text);
                    final result =
                        await accountService.getEmailVerifyCode(request);

                    if (result) {
                      snackBarService.show("이메일을 확인해주세요.");
                    }
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
                  onPressed: () async {
                    final result = await accountService.verifyEmailVerifyCode(
                        code: _verifyCodeTextEditingController.text,
                        email: _emailTextEditingController.text);

                    if (result == false) {
                      snackBarService.showError("인증코드가 일치하지 않아요.");
                      return;
                    } else {
                      snackBarService.show("이메일 인증이 완료되었어요!");
                    }
                  },
                  child: const Text("인증하기"))
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                final response = await accountService.changeEmail(
                    email: _emailTextEditingController.text,
                    code: _verifyCodeTextEditingController.text);

                if (mounted && response) {
                  Navigator.pop(context, _emailTextEditingController.text);
                }
              },
              child: const Text("저장"))
        ],
      ),
    );
  }
}
