import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/home/screen/home_screen.dart';
import 'package:photo_card_flutter/feature/login/service/login_service.dart';
import 'package:photo_card_flutter/feature/sign_up/screen/sign_up_screen.dart';
import 'package:photo_card_flutter/global/service/snack_bar_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();
  final service = LoginService();
  final snackBarService = SnackBarService();

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          _textFormField(
            context: context,
            controller: _idTextEditController,
            labelText: "아이디",
          ),
          _textFormField(
            context: context,
            controller: _passwordTextEditController,
            labelText: "비밀번호",
            obscureText: true,
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              child: const Text("회원가입")),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () async {
                final id = _idTextEditController.text;
                final password = _passwordTextEditController.text;

                final result = await service.login(id: id, password: password);
                if (result == false) return;

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text("로그인")),
        ]),
      ),
    ));
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
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText ?? false,
    );
  }
}
