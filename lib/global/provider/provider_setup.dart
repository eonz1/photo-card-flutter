import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../feature/bottom_navigation/bottom_navigation_notifier.dart';

Future<List<SingleChildWidget>> getProviders() async {
  return [
    ChangeNotifierProvider(create: (_) => BottomNavigationNotifier()),
  ];
}
