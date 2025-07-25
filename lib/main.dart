import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 37, 0, 132),
        ),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 36, 21, 251),
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
          backgroundColor: const Color.fromARGB(255, 36, 21, 251),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
      ),
    );
  }
}
