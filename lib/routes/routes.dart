import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do/features/authentication/presentation/screens/login_screen.dart';
import 'package:to_do/features/authentication/presentation/screens/register_screen.dart';
import 'package:to_do/features/task_management/presentation/screens/main_screen.dart';
import 'package:to_do/routes/go_router_refresh_stream.dart';

part 'routes.g.dart';

enum AppRoutes { splash, main, login, register }

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn &&
          (state.uri.toString() == '/login' ||
              state.uri.toString() == '/register')) {
        return '/main';
      } else if (!isLoggedIn && state.uri.toString().startsWith('/main')) {
        return '/login';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
