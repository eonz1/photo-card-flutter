import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_card_flutter/feature/bottom_navigation/model/bottom_navigation_notifier.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BottomNavigationNotifier>();
    final state = viewModel.state;

    return BottomNavigationBar(
      currentIndex: state,
      onTap: (index) {
        viewModel.set(index);

        switch (viewModel.state) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            if (context.mounted) context.goNamed("profile");
            break;
          default:
            break;
        }
      },
      items: [
        _bottomNavigationBarItem(icon: Icons.home, label: "홈"),
        _bottomNavigationBarItem(icon: Icons.chat, label: "채팅"),
        _bottomNavigationBarItem(icon: Icons.person, label: "내 정보")
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
