import 'package:go_router/go_router.dart';
import 'package:note/app/data/model/note_model.dart';
import 'package:note/app/modules/auth/bindings/auth_binding.dart';
import 'package:note/app/modules/auth/views/sign_in_view.dart';
import 'package:note/app/modules/auth/views/sign_up_view.dart';
import 'package:note/app/modules/home/bindings/home_binding.dart';
import 'package:note/app/modules/note/bindings/note_binding.dart';

import '../../main.dart';
import '../modules/home/views/home_view.dart';
import '../modules/note/views/note_view.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static GoRouter router = GoRouter(
    initialLocation: Routes.SPLASH,
    routes: [
      GoRoute(
        path: Routes.SPLASH,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.LOGIN,
        builder: (context, state) {
          AuthBinding().dependencies();
          return SignInView();
        },
      ),
      GoRoute(
        path: Routes.REGISTER,
        builder: (context, state) {
          AuthBinding().dependencies();
          return SignUpView();
        },
      ),
      GoRoute(
        path: Routes.HOME,
        builder: (context, state) {
          HomeBinding().dependencies();
          return const HomeView();
        },
      ),
      GoRoute(
        path: Routes.NOTE,
        builder: (context, state) {
          final note = state.extra as NoteModel?;
          NoteBinding(noteModel: note).dependencies();
          return const NoteView();
        },
      ),
    ],
  );
}
