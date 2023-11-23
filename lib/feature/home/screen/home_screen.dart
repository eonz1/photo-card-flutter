import 'package:flutter/material.dart';

import '../../bottom_navigation/screen/custom_bottom_navigation_bar.dart';
import '../../sign_up/screen/sign_up_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
              child: const Text("가입하기")),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    ));
  }
}
