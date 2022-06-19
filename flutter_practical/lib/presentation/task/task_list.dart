import 'package:flutter/material.dart';
import 'package:flutter_practical/presentation/login/user_details.dart';
import 'package:flutter_practical/presentation/login/login_page.dart';
import 'package:flutter_practical/presentation/login/sign_in.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:flutter_practical/presentation/task/add_edit_task.dart';
import 'package:flutter_practical/presentation/task/task_card.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_repository.dart';

// This class for display all the task in list
class TaskList extends StatelessWidget {
  final TaskRepository repository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            child: Text("TODO List"),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'Show Snackbar',
              onPressed: () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Get.to(
                      UserDetails(),
                    );
                  } else {
                    Get.to(
                      LoginPage(),
                    );
                  }
                });
              },
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddEditTask(
              task: Task(),
              isEdit: false,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final task = Task.fromSnapshot(snapshot);
    return TaskCard(task: task);
  }
}
