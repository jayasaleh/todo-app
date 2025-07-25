import 'package:flutter/material.dart';
import 'package:to_do/features/authentication/presentation/screens/accounts_screen.dart';
import 'package:to_do/features/task_management/presentation/screens/add_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/all_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/completed_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/incomplete_task_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  int currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = currentIndex;
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          AllTaskScreens(),
          IncompleteTaskScreens(),
          AddTaskScreens(),
          CompletedTaskScreens(),
          AccountsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        iconSize: 25.0,
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous_outlined),
            label: 'Incomplete',
            activeIcon: Icon(Icons.dangerous_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Task',
            activeIcon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Completed',
            activeIcon: Icon(Icons.check_box_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
            activeIcon: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
