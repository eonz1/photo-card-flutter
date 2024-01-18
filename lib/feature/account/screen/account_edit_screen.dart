import 'package:flutter/material.dart';

import '../../../global/logger.dart';
import '../api/account_response.dart';
import '../service/account_service.dart';
import 'email_bottom_sheet_widget.dart';
import 'nickname_bottom_sheet_widget.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({super.key});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final AccountService service = AccountService();

  late Future<AccountResponse> profileResponse;

  final _nicknameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _phoneNumberTextEditingController = TextEditingController();

  @override
  void dispose() {
    _nicknameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final result = service.getProfile();
    profileResponse = result;

    result.then((value) {
      _nicknameTextEditingController.text = value.nickname!;
      _emailTextEditingController.text = value.userEmail!;
      _phoneNumberTextEditingController.text = value.phoneNumber!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("내 정보 수정")),
      body: FutureBuilder(
          future: profileResponse,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _textFormField(
                    context: context,
                    controller: _nicknameTextEditingController,
                    labelText: "닉네임",
                    onTap: () async {
                      String? value = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return NicknameBottomSheetWidget(
                                nickname: _nicknameTextEditingController.text);
                          });

                      if (value != null && value.isNotEmpty) {
                        _nicknameTextEditingController.text = value;
                      }
                    },
                  ),
                  _textFormField(
                      context: context,
                      controller: _emailTextEditingController,
                      labelText: "이메일",
                      onTap: () async {
                        String? value = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const EmailBottomSheetWidget();
                            });

                        if (value != null && value.isNotEmpty) {
                          _emailTextEditingController.text = value;
                        }
                      }),
                ],
              ),
            );
          }),
    ));
  }

  TextFormField _textFormField(
      {required BuildContext context,
      required TextEditingController controller,
      required Function() onTap,
      String? labelText}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
          labelText: labelText, suffixIcon: const Icon(Icons.edit)),
    );
  }
}
