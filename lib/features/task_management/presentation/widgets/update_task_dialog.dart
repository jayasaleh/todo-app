import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/data/firestore_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

void showUpdateTaskDialog(BuildContext context, Task task, WidgetRef ref) {
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);
  int selectedPriority = ['Low', 'Medium', 'High'].indexOf(task.priority);
 
  final userId = ref.read(currentUserProvider)!.uid;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(
                SizeConfig.getProportionateScreenHeight(20),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Task',
                      style: AppStyles.headingTextStyle.copyWith(
                        fontSize: 20,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(20),
                    ),

                    // Task Title
                    Text(
                      'Task Title',
                      style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromARGB(255, 208, 208, 208),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.05),
                            blurRadius: 3,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: titleController,
                        style: AppStyles.normalTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Enter task title',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.title, size: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(20),
                    ),

                    // Task Description
                    Text(
                      'Task Description',
                      style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade100,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: descriptionController,
                        style: AppStyles.normalTextStyle.copyWith(
                          fontSize: 14,
                          color: Colors.blue.shade900,
                        ),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter task description',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.blue.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(20),
                    ),

                    // Priority Selection
                    Text(
                      'Priority',
                      style: AppStyles.headingTextStyle.copyWith(
                        fontSize: 16,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        3,
                        (index) => GestureDetector(
                          onTap: () => setState(() => selectedPriority = index),
                          child: Container(
                            margin: EdgeInsets.only(right: 11),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: selectedPriority == index
                                  ? _getPriorityColor(index).withOpacity(0.15)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedPriority == index
                                    ? _getPriorityColor(index)
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: selectedPriority == index
                                      ? _getPriorityColor(index)
                                      : Colors.grey,
                                  size: 12,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  ['Low', 'Medium', 'High'][index],
                                  style: AppStyles.normalTextStyle.copyWith(
                                    color: selectedPriority == index
                                        ? _getPriorityColor(index)
                                        : Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(30),
                    ),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            final updatedTask = task.copyWith(
                              title: titleController.text,
                              description: descriptionController.text,
                              priority: [
                                'Low',
                                'Medium',
                                'High',
                              ][selectedPriority],
                            );
                            ref
                                .read(firestoreRepositoryProvider)
                                .updateTask(
                                  task: updatedTask,
                                  taskId: task.id,
                                  userId: userId,
                                );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Update',
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Color _getPriorityColor(int index) {
  switch (['Low', 'Medium', 'High'][index]) {
    case 'Low':
      return Colors.blueAccent;
    case 'Medium':
      return Colors.orangeAccent;
    case 'High':
      return Colors.redAccent;
    default:
      return Colors.grey;
  }
}
