import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do/features/task_management/domain/task.dart';

part 'firestore_repository.g.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository(this._firestore);

  Future<void> addTask({required Task task, required String userId}) async {
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks') // Diperbaiki dari 'task' ke 'tasks'
        .add(task.toMap());
    await docRef.update({'id': docRef.id});
  }

  Future<void> updateTask({
    required Task task,
    required String taskId,
    required String userId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update(task.toMap());
  }

  Stream<List<Task>> loadTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Task.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<Task>> loadCompletedTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Task.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<Task>> loadIncompletedTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: false)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Task.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> deleteTask({
    required String userId,
    required String taskId,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Future<void> updateTaskCompletion({
    required String userId,
    required String taskId,
    required bool isComplete,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update({'isComplete': isComplete});
  }
}

// Provider untuk repository
@Riverpod(keepAlive: true)
FirestoreRepository firestoreRepository(FirestoreRepositoryRef ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
}

// Provider untuk tasks
@riverpod
Stream<List<Task>> loadTasks(LoadTasksRef ref, String userId) {
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.loadTasks(userId);
}

// Provider untuk completed tasks
@riverpod
Stream<List<Task>> loadCompletedTasks(
  LoadCompletedTasksRef ref,
  String userId,
) {
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.loadCompletedTasks(userId);
}

// Provider untuk incompleted tasks
@riverpod
Stream<List<Task>> loadIncompletedTasks(
  LoadIncompletedTasksRef ref,
  String userId,
) {
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.loadIncompletedTasks(userId);
}
