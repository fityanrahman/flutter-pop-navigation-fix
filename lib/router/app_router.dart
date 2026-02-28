import 'package:go_router/go_router.dart';
import 'package:router_experiment/const/app_routes_const.dart';
import 'package:router_experiment/screens/add_item_screen.dart';
import 'package:router_experiment/screens/add_notes_screen.dart';
import 'package:router_experiment/screens/list_screen.dart';

class AppRouter {
  static late GoRouter router;

  static Future<void> init() async {
    router = GoRouter(
      initialLocation: AppRoutesConst.listScreen,
      routes: [
        GoRoute(
          path: AppRoutesConst.listScreen,
          builder: (context, state) => const ListScreen(),
        ),
        GoRoute(
          path: AppRoutesConst.addItemScreen,
          builder: (context, state) => AddItemScreen(),
        ),
        GoRoute(
          path: AppRoutesConst.addNotesScreen,
          builder: (context, state) => const AddNotesScreen(),
        ),
      ],
    );
  }
}
