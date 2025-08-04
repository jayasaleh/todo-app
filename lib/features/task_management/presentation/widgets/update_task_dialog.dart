import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/data/firestore_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

void showUpdateTaskDialog(BuildContext context, Task task, WidgetRef ref) {
  final userId = ref.read(currentUserProvider)!.uid;

  showDialog(
    context: context,
    builder: (context) {
      return _UpdateTaskDialogContent(task: task, ref: ref, userId: userId);
    },
  );
}

class _UpdateTaskDialogContent extends StatefulWidget {
  final Task task;
  final WidgetRef ref;
  final String userId;

  const _UpdateTaskDialogContent({
    required this.task,
    required this.ref,
    required this.userId,
  });

  @override
  State<_UpdateTaskDialogContent> createState() =>
      _UpdateTaskDialogContentState();
}

class _UpdateTaskDialogContentState extends State<_UpdateTaskDialogContent> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late int _selectedPriority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _selectedPriority = ['Low', 'Medium', 'High'].indexOf(widget.task.priority);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

  // Fungsi untuk menampilkan pesan toast dengan cepat
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenHeight(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            // Mengganti Form dengan Column untuk validasi manual
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
              SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

              // Task Title
              Text(
                'Task Title',
                style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _titleController,
                  style: AppStyles.normalTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.blue.shade900,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter task title',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.blue.shade400,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

              // Task Description
              Text(
                'Task Description',
                style: AppStyles.headingTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
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
              SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

              // Priority Selection
              Text(
                'Priority',
                style: AppStyles.headingTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  3,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedPriority = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedPriority == index
                            ? _getPriorityColor(index).withOpacity(0.15)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedPriority == index
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
                            color: _selectedPriority == index
                                ? _getPriorityColor(index)
                                : Colors.grey,
                            size: 12,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ['Low', 'Medium', 'High'][index],
                            style: AppStyles.normalTextStyle.copyWith(
                              color: _selectedPriority == index
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
              SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

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
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      // Validasi manual menggunakan toaster
                      if (_titleController.text.trim().isEmpty) {
                        _showToast('Title cannot be empty');
                        return; // Hentikan eksekusi jika validasi gagal
                      }
                      if (_descriptionController.text.trim().isEmpty) {
                        _showToast('Description cannot be empty');
                        return; // Hentikan eksekusi jika validasi gagal
                      }

                      // Jika validasi berhasil, jalankan logika update
                      final updatedTask = widget.task.copyWith(
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        priority: ['Low', 'Medium', 'High'][_selectedPriority],
                      );
                      widget.ref
                          .read(firestoreRepositoryProvider)
                          .updateTask(
                            task: updatedTask,
                            taskId: widget.task.id,
                            userId: widget.userId,
                          );

                      Navigator.pop(context);

                      // Tampilkan toast berhasil
                      Fluttertoast.showToast(
                        msg: "Task successfully updated!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
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
  }
}
