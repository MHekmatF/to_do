
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/task_model.dart';
import 'models/user_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
      getUsersCollection()
          .doc(userId)
          .collection('tasks')
          // FirebaseFirestore.instance.collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );
  static Future<void> addTaskToFirestore(TaskModel taskModel, String userId) {
    final taskCollection = getTasksCollection(userId);
    final doc = taskCollection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }  static Future<void> editTaskFirestore(TaskModel taskModel, String userId) {
    final taskCollection = getTasksCollection(userId);
    final doc = taskCollection.doc(taskModel.id);
    return doc.update(taskModel.toJson());
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore(String userId) async {
    final taskCollection = getTasksCollection(userId);
    final querySnapshot = await taskCollection.get();
//    return querySnapshot.docs.map((doc) => doc.data()).toList();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId, String userId) {
    final taskCollection = getTasksCollection(userId);
    return taskCollection.doc(taskId).delete();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = UserModel(id: credentials.user!.uid, name: name, email: email);
    final usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    final credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final usersCollection = getUsersCollection();
    final docSnapshot = await usersCollection.doc(credentials.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logOut() {
    return FirebaseAuth.instance.signOut();
  }
}
