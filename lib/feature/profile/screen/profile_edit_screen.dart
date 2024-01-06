import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/profile/screen/email_bottom_sheet_widget.dart';
import 'package:photo_card_flutter/feature/profile/screen/nickname_bottom_sheet_widget.dart';

import '../api/profile_response.dart';
import '../service/profile_service.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final ProfileService service = ProfileService();

  late Future<ProfileResponse> profileResponse;

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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Text("프로필 사진"),
                  ),
                  _textFormField(
                    context: context,
                    controller: _nicknameTextEditingController,
                    labelText: "닉네임",
                    bottomSheetWidget: NicknameBottomSheetWidget(
                        nickname: _nicknameTextEditingController.text),
                  ),
                  _textFormField(
                    context: context,
                    controller: _emailTextEditingController,
                    labelText: "이메일",
                    bottomSheetWidget: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: EmailBottomSheetWidget(),
                    ),
                  ),
                  _textFormField(
                    context: context,
                    controller: _phoneNumberTextEditingController,
                    labelText: "전화번호",
                    bottomSheetWidget: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                          child: Column(
                        children: [TextFormField()],
                      )),
                    ),
                  ),
                ],
              ),
            );
          }),
    ));
  }

  TextFormField _textFormField({
    required BuildContext context,
    required Widget bottomSheetWidget,
    required TextEditingController controller,
    String? labelText,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        String? value = await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return bottomSheetWidget;
            });

        if (value != null) controller.text = value;
      },
      decoration: InputDecoration(
          labelText: labelText, suffixIcon: const Icon(Icons.edit)),
    );
  }
}
