import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncompleteTaskScreens extends ConsumerStatefulWidget {
  const IncompleteTaskScreens({super.key});

  @override
  ConsumerState<IncompleteTaskScreens> createState() =>
      _IncompleteTaskScreensState();
}

class _IncompleteTaskScreensState extends ConsumerState<IncompleteTaskScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Incomplete Tasks')));
  }
}
