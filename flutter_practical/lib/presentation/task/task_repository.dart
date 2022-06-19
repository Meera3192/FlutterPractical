import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:flutter_practical/presentation/login/sign_in.dart';

// This class for accessing database from firestore
class TaskRepository {

  // get Collection
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Task');

  // get ALl Data
  Stream<QuerySnapshot> getStream() {
    return collection.where('UserId',isEqualTo: uid).snapshots();
  }

  // Add Collection
  Future<DocumentReference> addTask(Task task) {
    return collection.add(task.toJson());
  }

  // Update Collection
  updateTask(Task task) async {
    await collection.doc(task.taskId).update(task.toJson());
  }

  // Delete Colection
  deleteTask(Task task) async {
    await collection.doc(task.taskId).delete();
  }

}