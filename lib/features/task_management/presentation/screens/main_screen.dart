import 'package:flutter/material.dart';
import 'package:to_do/features/authentication/presentation/screens/accounts_screen.dart';
import 'package:to_do/features/task_management/presentation/screens/add_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/all_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/completed_task_screens.dart';
import 'package:to_do/features/task_management/presentation/screens/incomplete_task_screens.dart';
import 'package:to_do/utils/app_styles.dart';

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
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: const [
          AllTaskScreens(),
          IncompleteTaskScreens(),
          AddTaskScreens(),
          CompletedTaskScreens(),
          AccountsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromRGBO(21, 101, 192, 1),
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: AppStyles.normalTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppStyles.normalTextStyle.copyWith(
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: currentIndex == 0
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.home),
              ),
              label: 'All Tasks',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: currentIndex == 1
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.pending_actions_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.pending_actions),
              ),
              label: 'Overdue',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: currentIndex == 2
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add),
              ),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: currentIndex == 3
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.check_circle_outline_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.check_circle),
              ),
              label: 'Completed',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: currentIndex == 4
                      ? Colors.blue.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person_outline_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
