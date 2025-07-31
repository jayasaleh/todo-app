import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/common_widgets/async_value_widget.dart';
import 'package:to_do/features/authentication/data/auth_repository.dart';
import 'package:to_do/features/task_management/data/firestore_repository.dart';
import 'package:to_do/features/task_management/domain/task.dart';
import 'package:to_do/features/task_management/presentation/widgets/task_item.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';
// Pastikan Anda memiliki import untuk Timestamp jika belum ada
// import 'package:cloud_firestore/cloud_firestore.dart';

class IncompleteTaskScreens extends ConsumerStatefulWidget {
  const IncompleteTaskScreens({super.key});

  @override
  ConsumerState<IncompleteTaskScreens> createState() =>
      _IncompleteTaskScreensState();
}

class _IncompleteTaskScreensState extends ConsumerState<IncompleteTaskScreens> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final userId = ref.watch(currentUserProvider)!.uid;
    final tasksAsync = ref.watch(loadIncompletedTasksProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Overdue Tasks',
          style: AppStyles.headingTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: AsyncValueWidget<List<Task>>(
        value: tasksAsync,
        data: (tasks) {
          final now = DateTime.now();
          final filteredOverdueTasks = tasks.where((task) {
            final taskDateOnly = DateTime(
              task.date.toDate().year,
              task.date.toDate().month,
              task.date.toDate().day,
            );
            final todayDateOnly = DateTime(now.year, now.month, now.day);
            return taskDateOnly.isBefore(todayDateOnly);
          }).toList();

          if (filteredOverdueTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No overdue tasks!',
                    style: AppStyles.headingTextStyle.copyWith(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'re all caught up',
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
            itemCount: filteredOverdueTasks.length,
            itemBuilder: (context, index) {
              final task = filteredOverdueTasks[index];

              // --- FOKUS UTAMA PERBAIKAN DI SINI ---
              // 1. Dapatkan DateTime saat ini
              final now = DateTime.now();

              // 2. Normalisasi DateTime saat ini ke awal hari (tengah malam)
              final todayMidnight = DateTime(now.year, now.month, now.day);

              // 3. Konversi Timestamp task.date ke DateTime, lalu normalisasi ke awal hari
              final taskDueDateMidnight = DateTime(
                task.date.toDate().year,
                task.date.toDate().month,
                task.date.toDate().day,
              );

              // 4. Hitung perbedaan dalam hari
              // Ini akan memberikan jumlah hari penuh antara kedua tanggal tengah malam
              final daysOverdue = todayMidnight
                  .difference(taskDueDateMidnight)
                  .inDays;
              // --- AKHIR FOKUS PERBAIKAN ---

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main Task Item
                    TaskItem(task),
                    Positioned(
                      top: 8,
                      right: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$daysOverdue ${daysOverdue == 1 ? 'day' : 'days'} overdue',
                          style: const TextStyle(
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
