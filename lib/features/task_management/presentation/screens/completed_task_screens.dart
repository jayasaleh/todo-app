import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletedTaskScreens extends ConsumerStatefulWidget {
  const CompletedTaskScreens({super.key});

  @override
  ConsumerState<CompletedTaskScreens> createState() => _CompletedTaskScreens();
}

class _CompletedTaskScreens extends ConsumerState<CompletedTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Completed Mantap')));
  }
}
