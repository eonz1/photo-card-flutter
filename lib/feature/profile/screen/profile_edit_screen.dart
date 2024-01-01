import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/profile/screen/profile_notifier.dart';
import 'package:provider/provider.dart';

import '../../../global/logger.dart';
import '../api/profile_response.dart';
import '../service/profile_service.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final ProfileService service = ProfileService();

  final _nicknameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _emailVerifyCodeTextEditingController = TextEditingController();

  late String originNickname;
  late String originEmail;

  late Future<ProfileResponse> profileResponse;

  @override
  void dispose() {
    _nicknameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final result = service.getProfile();
    profileResponse = result;

    result.then((value) {
      _nicknameTextEditingController.text = value.nickname!;
      _emailTextEditingController.text = value.userEmail!;

      originNickname = value.nickname!;
      originEmail = value.userEmail!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileNotifier>();
    String nickname = _nicknameTextEditingController.text;
    String email = _emailTextEditingController.text;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("내 정보 수정"), actions: [
        TextButton(
            onPressed: () async {
              // TODO : 확인하기
              final result = await service.saveProfile(
                  userEmail: email, nickname: nickname);
            },
            child: const Text("완료"))
      ]),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Text("프로필 사진"),
                  ),
                  TextFormField(
                    controller: _nicknameTextEditingController,
                    onChanged: (value) => viewModel.changeNickname(value),
                    decoration: const InputDecoration(labelText: "닉네임"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text("이메일은 인증해야 변경할 수 있어요."),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: _emailTextEditingController,
                          onChanged: (value) => viewModel.changeEmail(value),
                          decoration: const InputDecoration(labelText: "이메일"),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            // TODO : 이메일 인증 코드 받기
                          },
                          child: const Text("인증코드 전송"))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: _emailVerifyCodeTextEditingController,
                          decoration:
                              const InputDecoration(labelText: "이메일 인증 코드"),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            // TODO : 코드 인증 하기
                          },
                          child: const Text("인증하기"))
                    ],
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
