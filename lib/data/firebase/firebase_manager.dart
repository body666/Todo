import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';
class FirebaseManager {

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    task.createdAt = Timestamp.now(); // Set
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date,) {
    return getTasksCollection()
        .where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid)
        .where("date",isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .orderBy("createdAt")
        .snapshots();
  }

  static Future<void> deleteTask(String taskId)async {
    return getTasksCollection().doc(taskId).delete();
  }

  static void updateTask(TaskModel model){
    getTasksCollection().doc(model.id).update(model.toJson());
  }

  static Future<void> editTask(TaskModel task){
    return getTasksCollection().doc(task.id).update(task.toJson());
  }


  /////////////////////////////////////////////////////////firebase authentication

  static CollectionReference<userModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<userModel>(
      fromFirestore: (snapshot, _) {
        return userModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<void> addUser(userModel user){
    var collection=getUsersCollection();
    var docRef=collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<userModel?> readUser(String id)async{
   DocumentSnapshot<userModel> userDoc=await getUsersCollection().doc(id).get();
   return userDoc.data();
 }

  static Future<void> CreateAccount
      (String email,String password,String username,Function OnSuccess,Function OnError)async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      userModel UserModel=userModel(email: email, id: credential.user!.uid, username:username);
      FirebaseManager.addUser(UserModel);
      OnSuccess();

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        OnError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        OnError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


















}
