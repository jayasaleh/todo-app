import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/data/firestore_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/features/task_management/presentation/widgets/delete_task_dialog.dart';
import 'package:to_do/features/task_management/presentation/widgets/update_task_dialog.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

String formattedDate(dynamic date) {
  try {
    // Handle Timestamp
    if (date is Timestamp) {
      return DateFormat('dd MMM yyyy').format(date.toDate());
    }
    // Handle String
    else if (date is String) {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    }
    // Handle DateTime langsung
    else if (date is DateTime) {
      return DateFormat('dd MMM yyyy').format(date);
    }
    throw ArgumentError('Tipe data tanggal tidak didukung');
  } catch (e) {
    debugPrint('Error formatting date: $e');
    return 'Tanggal tidak valid';
  }
}

Color getPriorityColor(String priority) {
  switch (priority.toUpperCase()) {
    case 'LOW':
      return Colors.blueAccent;
    case 'MEDIUM':
      return Colors.orangeAccent;
    case 'HIGH':
      return Colors.redAccent;
    default:
      return Colors.grey;
  }
}

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem(this.task, {super.key});
  final Task task;

  @override
  ConsumerState createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isComplete = widget.task.isComplete;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: isComplete ? Colors.grey.shade200 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isComplete ? Colors.greenAccent : Colors.blue.shade100,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox - lebih kompak
          SizedBox(
            width: 24, // Lebar tetap untuk checkbox
            child: Checkbox(
              value: isComplete,
              activeColor: Colors.green,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onChanged: (bool? value) {
                if (value == null) return;
                final userId = ref.watch(currentUserProvider)!.uid;
                ref
                    .read(firestoreRepositoryProvider)
                    .updateTaskCompletion(
                      userId: userId,
                      taskId: widget.task.id,
                      isComplete: value,
                    );
              },
            ),
          ),
          const SizedBox(width: 8), // Mengurangi jarak dari checkbox
          // Task details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.task.title,
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: 19,
                    color: isComplete ? Colors.grey : Colors.blue.shade900,
                    decoration: isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                // Description
                Text(
                  widget.task.description,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: isComplete ? Colors.grey : Colors.black87,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                // Priority & Date
                Row(
                  children: [
                    // Priority
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: getPriorityColor(
                          widget.task.priority,
                        ).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: getPriorityColor(widget.task.priority),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag,
                            color: getPriorityColor(widget.task.priority),
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.task.priority.toUpperCase(),
                            style: AppStyles.normalTextStyle.copyWith(
                              color: getPriorityColor(widget.task.priority),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Date
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                            size: 15,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            formattedDate(widget.task.date),
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Edit & Delete buttons
          Column(
            children: [
              // Edit
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  showUpdateTaskDialog(context, widget.task, ref);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 22),
                ),
              ),
              // Delete
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  showDeleteTaskDialog(context, widget.task, ref);
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
