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
        .collection('tasks')
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
    // Get today's range in UTC
    final now = DateTime.now().toUtc();
    final todayStart = DateTime.utc(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('date', isLessThan: Timestamp.fromDate(todayEnd))
        .orderBy('date', descending: false)
        .snapshots()
        .map(
          (snap) => snap.docs.map((doc) => Task.fromMap(doc.data())).toList(),
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

  Future<Timestamp> _serverNow() async {
    final snap = await FirebaseFirestore.instance
        .collection('utils')
        .doc('serverTime')
        .get();

    if (snap.exists) {
      return snap.get('time');
    } else {
      return Timestamp.now();
    }
  }

  Stream<List<Task>> loadIncompletedTasks(String userId) async* {
    // 1. Get the current time from the server
    final serverTimestamp = await _serverNow();

    // 2. Convert the Firestore Timestamp to a Dart DateTime object
    final serverDateTime = serverTimestamp.toDate();

    // 3. Calculate the beginning of the current day (midnight)
    final startOfToday = DateTime(
      serverDateTime.year,
      serverDateTime.month,
      serverDateTime.day, // Sets time to 00:00:00
    );

    // 4. Convert the "start of day" DateTime back to a Firestore Timestamp
    final startOfTodayTimestamp = Timestamp.fromDate(startOfToday);

    // 5. Use the "start of day" timestamp in your query
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: false)
        // ✅ This now correctly finds tasks from previous days
        .where('date', isLessThan: startOfTodayTimestamp)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Task.fromMap(d.data())).toList());
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
