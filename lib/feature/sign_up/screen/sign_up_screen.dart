import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/sign_up/model/sign_up_notifier.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpNotifier>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _textFormField(
                            context: context,
                            labelText: "아이디",
                            errorText: viewModel.id.error,
                            onChanged: (value) {
                              viewModel.changeId(value);
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              // TODO: 기능 추가
                            },
                            child: const Text("중복 확인"))
                      ],
                    ),
                    _textFormField(
                      context: context,
                      labelText: "비밀번호",
                      errorText: viewModel.password.error,
                      hintText: "영문, 숫자, 특수문자 조합 8-16자",
                      onChanged: (value) {
                        viewModel.changePassword(value);
                      },
                      obscureText: true,
                    ),
                    _textFormField(
                      context: context,
                      labelText: "비밀번호 확인",
                      errorText: viewModel.reEnterPassword.error,
                      onChanged: (value) {
                        viewModel.changeReEnterPassword(value);
                      },
                      obscureText: true,
                    ),
                    _textFormField(
                      context: context,
                      labelText: "이메일",
                      errorText: viewModel.email.error,
                      hintText: "예) photocard@photocard.co.kr",
                      onChanged: (value) {
                        viewModel.changeEmail(value);
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _textFormField(
                            context: context,
                            labelText: "휴대폰 번호",
                            errorText: viewModel.phoneNumber.error,
                            hintText: "\'-\' 구분없이 입력",
                            onChanged: (value) {
                              viewModel.changePhoneNumber(value);
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              // TODO: 기능추가
                            },
                            child: const Text("인증번호 전송"))
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: viewModel.canPress == false
                      ? null
                      : () async {
                          final isEqualPassword = viewModel.isEqualPassword();
                          if (!isEqualPassword) return;
                        },
                  child: const Text("가입하기"))
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _textFormField({
    required BuildContext context,
    String? labelText,
    required String? errorText,
    required ValueChanged<String>? onChanged,
    bool? obscureText,
    String? hintText,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
      ),
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText ?? false,
    );
  }
}
