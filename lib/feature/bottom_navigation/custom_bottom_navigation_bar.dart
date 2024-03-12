import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_notifier.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BottomNavigationNotifier>();
    final state = viewModel.state;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: state,
      onTap: (index) {
        viewModel.set(index);

        switch (viewModel.state) {
          case 0:
            if (context.mounted) context.goNamed("home");
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            if (context.mounted) context.goNamed("profile");
            break;
          default:
            break;
        }
      },
      items: [
        _bottomNavigationBarItem(icon: Icons.home, label: "포카검색"),
        _bottomNavigationBarItem(icon: Icons.add, label: "판매"),
        _bottomNavigationBarItem(icon: Icons.chat, label: "채팅"),
        _bottomNavigationBarItem(icon: Icons.person, label: "마이")
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
