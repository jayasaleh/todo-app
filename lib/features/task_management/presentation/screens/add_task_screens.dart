import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
              controller: _titleController,
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
                            _selectedPriorities = index;
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.getProportionateScreenWidth(10),
                            ),
                            padding: EdgeInsets.all(
                              SizeConfig.getProportionateScreenHeight(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
