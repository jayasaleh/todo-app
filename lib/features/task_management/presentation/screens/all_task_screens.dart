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
          'My Tasks Today',
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
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.getProportionateScreenHeight(150),
            width: SizeConfig.getProportionateScreenWidth(150),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.task_outlined,
              size: 80,
              color: Colors.blue.shade300,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
          Text(
            'No Tasks Yet',
            style: AppStyles.headingTextStyle.copyWith(
              fontSize: 22,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(40),
            ),
            child: Text(
              'You don\'t have any tasks yet. Tap the + button to add your first task!',
              textAlign: TextAlign.center,
              style: AppStyles.normalTextStyle.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
