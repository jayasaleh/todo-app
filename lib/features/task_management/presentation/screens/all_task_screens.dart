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

class AllTaskScreens extends ConsumerStatefulWidget {
  const AllTaskScreens({super.key});

  @override
  ConsumerState<AllTaskScreens> createState() => _AllTaskScreensState();
}

class _AllTaskScreensState extends ConsumerState<AllTaskScreens> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final taskAsyncValue = ref.watch(loadTasksProvider(userId));

    ref.listen<AsyncValue>(loadTasksProvider(userId), (_, state) {
      state.showAlertDialogError(context);
    });
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Task Today',
          style: AppStyles.headingTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: AsyncValueWidget<List<Task>>(
        value: taskAsyncValue,
        data: (tasks) {
          return tasks.isEmpty
              ? const Center(child: Text('No task yet...'))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(task);
                  },
                  itemCount: tasks.length,
                );
        },
      ),
    );
  }
}
