import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/bottom_navigation/screen/custom_bottom_navigation_bar.dart';
import 'package:photo_card_flutter/feature/sign_up/screen/sign_up_screen.dart';

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
        body: SignUpScreen(),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
