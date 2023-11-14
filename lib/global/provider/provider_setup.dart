import 'package:photo_card_flutter/feature/bottom_navigation/model/bottom_navigation_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> getProviders() async {

  return [
    ChangeNotifierProvider(create: (_) => BottomNavigationNotifier()),
  ];
}