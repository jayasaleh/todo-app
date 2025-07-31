  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:to_do/features/task_management/domain/task.dart';
  import 'package:to_do/features/task_management/presentation/firestore_controller.dart';
  import 'package:to_do/features/task_management/presentation/widgets/task_dialog.dart';
  import 'package:to_do/utils/app_styles.dart';
  import 'package:to_do/features/authentication/data/auth_repository.dart';

  void showDeleteTaskDialog(BuildContext context, Task task, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          title: 'Delete Task',
          content: Text(
            'Are you sure you want to delete "${task.title}"?',
            style: AppStyles.normalTextStyle.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppStyles.normalTextStyle.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                ref
                    .read(firestoreControllerProvider.notifier)
                    .deleteTask(taskId: task.id, userId: userId);
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: AppStyles.normalTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
