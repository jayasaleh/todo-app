import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/authentication/presentation/controllers/auth_controller.dart';

class AllTaskScreens extends ConsumerStatefulWidget {
  const AllTaskScreens({super.key});

  @override
  ConsumerState<AllTaskScreens> createState() => _AllTaskScreensState();
}

class _AllTaskScreensState extends ConsumerState<AllTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  } 
}
