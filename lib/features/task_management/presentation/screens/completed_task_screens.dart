import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/common_widgets/async_value_widget.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/data/firestore_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/features/task_management/presentation/widgets/task_item.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

class CompletedTaskScreens extends ConsumerStatefulWidget {
  const CompletedTaskScreens({super.key});

  @override
  ConsumerState<CompletedTaskScreens> createState() =>
      _CompletedTaskScreensState();
}

class _CompletedTaskScreensState extends ConsumerState<CompletedTaskScreens> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final userId = ref.watch(currentUserProvider)!.uid;
    final tasksAsync = ref.watch(loadCompletedTasksProvider(userId));

    ref.listen<AsyncValue>(loadCompletedTasksProvider(userId), (_, state) {
      state.showAlertDialogError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Tasks',
          style: AppStyles.headingTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: AsyncValueWidget<List<Task>>(
        value: tasksAsync,
        data: (completedTasks) {
          if (completedTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No completed tasks yet',
                    style: AppStyles.headingTextStyle.copyWith(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete some tasks to see them here',
                    style: AppStyles.normalTextStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    TaskItem(task),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
