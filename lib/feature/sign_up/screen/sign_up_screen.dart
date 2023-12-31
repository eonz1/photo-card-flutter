import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_card_flutter/feature/login/screen/login_screen.dart';
import 'package:photo_card_flutter/feature/sign_up/api/verify_email_request.dart';
import 'package:photo_card_flutter/feature/sign_up/service/sign_up_service.dart';
import 'package:photo_card_flutter/global/service/snack_bar_service.dart';
import 'package:provider/provider.dart';

import '../model/sign_up_notifier.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailVerifyCodeTextEditController = TextEditingController();

  @override
  void dispose() {
    _emailVerifyCodeTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpNotifier>();
    final snackBarService = SnackBarService();
    final service = SignUpService();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("가입하기 화면"),
        ),
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
                            hintText: "영문 소문자, 숫자 5-20자",
                            errorText: viewModel.id.error,
                            onChanged: (value) {
                              viewModel.changeId(value);
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              final result = await service.isDuplicatedId(
                                  id: viewModel.id.value);

                              viewModel.isDuplicatedId(result);

                              if (!result) {
                                snackBarService.show("사용 가능한 아이디에요.");
                              }
                            },
                            child: const Text("중복 확인"))
                      ],
                    ),
                    _textFormField(
                      context: context,
                      labelText: "비밀번호",
                      errorText: viewModel.password.error,
                      hintText: "영문 대/소문자, 숫자, 특수문자 조합 8-16자",
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
                    Row(
                      children: [
                        Expanded(
                          child: _textFormField(
                            context: context,
                            labelText: "이메일",
                            errorText: viewModel.email.error,
                            hintText: "예) photocard@photocard.co.kr",
                            onChanged: (value) {
                              viewModel.changeEmail(value);
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              final request = VerifyEmailRequest(
                                  userEmail: viewModel.email.value);

                              final result =
                                  await service.getEmailVerifyCode(request);

                              if (result) {
                                snackBarService.show("이메일을 확인해주세요.");
                              }
                            },
                            child: const Text("인증번호 전송"))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _textFormField(
                            controller: _emailVerifyCodeTextEditController,
                            context: context,
                            labelText: "이메일 번호 인증코드",
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              final result =
                                  await service.verifyEmailVerifyCode(
                                      _emailVerifyCodeTextEditController.text,
                                      viewModel.email.value);

                              if (result == false) {
                                snackBarService.showError("인증코드가 일치하지 않아요.");
                              } else {
                                snackBarService.show("이메일 인증이 완료되었어요!");
                              }

                              viewModel.isEmailVerify(result);
                              viewModel.vaildSignUpButton();
                            },
                            child: const Text("인증하기"))
                      ],
                    ),
                    _textFormField(
                      context: context,
                      labelText: "휴대폰 번호",
                      errorText: viewModel.phoneNumber.error,
                      hintText: "\'-\' 구분없이 입력",
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        viewModel.changePhoneNumber(value);
                      },
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

                          // TODO: 아이디 중복 확인 했는 지
                          // TODO: 이메일 인증 했는 지

                          final result = await service.signUp(
                              id: viewModel.id.value,
                              password: viewModel.password.value,
                              phoneNumber: viewModel.phoneNumber.value,
                              email: viewModel.email.value);

                          if (result.resultCode == 201) {
                            // TODO: gorouter로 이동
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
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
    TextEditingController? controller,
    String? labelText,
    String? errorText,
    ValueChanged<String>? onChanged,
    bool? obscureText,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText ?? false,
    );
  }
}
