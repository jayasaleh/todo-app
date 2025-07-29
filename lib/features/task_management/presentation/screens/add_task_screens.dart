import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/features/task_management/presentation/firestore_controller.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

class AddTaskScreens extends ConsumerStatefulWidget {
  const AddTaskScreens({super.key});
  @override
  ConsumerState<AddTaskScreens> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreens> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  int _selectedPriorities = 0;

  Color _getPriorityColor(int index) {
    switch (_priorities[index]) {
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final userId = ref.watch(currentUserProvider)!.uid;
    final state = ref.watch(firestoreControllerProvider);
    ref.listen<AsyncValue>(firestoreControllerProvider, (_, state) {
      state.showAlertDialogError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Task',
          style: AppStyles.headingTextStyle.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(10),
          vertical: SizeConfig.getProportionateScreenHeight(10),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              Text(
                'Task Title',
                style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 208, 208, 208),
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
                  controller: _titleController,
                  style: AppStyles.normalTextStyle.copyWith(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Enter task title',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.title, size: 20),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

              // Task Description
              Text(
                'Task Description',
                style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _descriptionController,
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
              SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),

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
                  _priorities.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedPriorities = index),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedPriorities == index
                            ? _getPriorityColor(index).withOpacity(0.15)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedPriorities == index
                              ? _getPriorityColor(index)
                              : Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flag,
                            color: _selectedPriorities == index
                                ? _getPriorityColor(index)
                                : Colors.grey,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            _priorities[index],
                            style: AppStyles.normalTextStyle.copyWith(
                              color: _selectedPriorities == index
                                  ? _getPriorityColor(index)
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

              // Add Task Button
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  String priority = _priorities[_selectedPriorities];

                  final createTask = Task(
                    title: title,
                    description: description,
                    priority: priority,
                    date: Timestamp.now(),
                  );
                  ref
                      .read(firestoreControllerProvider.notifier)
                      .addTask(task: createTask, userId: userId);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.getProportionateScreenHeight(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: state.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Add Task',
                              style: AppStyles.titleTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
