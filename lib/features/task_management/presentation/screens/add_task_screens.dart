import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/common_widgets/async_value_ui.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/features/task_management/presentation/firestore_controller.dart';
import 'package:to_do/features/task_management/presentation/widgets/title_description.dart';
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
        return Colors.blue;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
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
          style: AppStyles.titleTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            TitleDescription(
              title: 'Task Title',
              hintText: 'Enter task title',
              maxLines: 1,
              controller: _titleController,
              prefixIcon: Icons.notes,
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
            TitleDescription(
              title: 'Task Description',
              hintText: 'Enter task description',
              maxLines: 1,
              controller: _descriptionController,
              prefixIcon: Icons.notes,
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            Row(
              children: [
                Text(
                  'Priority',
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: SizeConfig.getProportionateScreenHeight(18),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: SizeConfig.getProportionateScreenHeight(40),
                    child: ListView.builder(
                      itemCount: _priorities.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final priority = _priorities[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPriorities = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.getProportionateScreenWidth(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  SizeConfig.getProportionateScreenHeight(10),
                              vertical: SizeConfig.getProportionateScreenHeight(
                                8,
                              ),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _selectedPriorities == index
                                  ? _getPriorityColor(index)
                                  : Colors.black26,
                            ),
                            child: Text(
                              priority,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: _selectedPriorities == index
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(25)),
            InkWell(
              onTap: () {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();
                String priority = _priorities[_selectedPriorities];
                String date = DateTime.now().toString();
                final createTask = Task(
                  title: title,
                  description: description,
                  priority: priority,
                  date: date,
                );
                ref
                    .read(firestoreControllerProvider.notifier)
                    .addTask(task: createTask, userId: userId);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.getProportionateScreenHeight(50),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 13, 94, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: state.isLoading
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 28),
                          Text(
                            'Add Task',
                            style: AppStyles.titleTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
