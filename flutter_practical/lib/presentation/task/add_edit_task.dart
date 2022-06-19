import 'package:flutter/material.dart';
import 'package:flutter_practical/controller/add_edit_task_controller.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:flutter_practical/presentation/login/user_details.dart';
import 'package:flutter_practical/presentation/login/login_page.dart';
import 'package:flutter_practical/presentation/login/sign_in.dart';
import 'package:flutter_practical/presentation/task/task_list.dart';
import 'package:flutter_practical/presentation/task/task_repository.dart';
import 'package:flutter_practical/widget/common_button.dart';
import 'package:flutter_practical/widget/common_input_text_box.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Class for add and edit task
class AddEditTask extends StatelessWidget {
  Task task = Task();
  bool isEdit = false;

  AddEditTask({Key? key, required this.task, this.isEdit = false});

  final AddEditTaskController addEditTaskController =
      Get.put(AddEditTaskController());

  final TaskRepository repository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    addEditTaskController.initController(task, isEdit);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Container(
              child: Text("Task Details"),
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
        body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  CommonInputTextBox(
                    focusNode: addEditTaskController.focusName,
                    nextFocusNode: addEditTaskController.focusDescription,
                    textLimit: 20,
                    text: "Name",
                    hintText: 'Enter Task Name',
                    boxHeight: 40,
                    isEnabled: true,
                    boxWidth: double.infinity,
                    tf_controller: addEditTaskController.nameController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CommonInputTextBox(
                    focusNode: addEditTaskController.focusDescription,
                    nextFocusNode: addEditTaskController.focusDate,
                    textLimit: 100,
                    text: "Description",
                    hintText: 'Enter Task Description',
                    boxHeight: 35,
                    isEnabled: true,
                    boxWidth: double.infinity,
                    tf_controller: addEditTaskController.desciptionController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Date",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: Color(0xaa212529),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            DateFormat("dd/MM/yyyy")
                                .format(
                                    addEditTaskController.selectedDate.value)
                                .toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          tooltip: 'Show Snackbar',
                          onPressed: () {
                            addEditTaskController.chooseDate();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  (addEditTaskController.errorMsg != null &&
                          addEditTaskController.errorMsg.isNotEmpty)
                      ? Text(
                          addEditTaskController.errorMsg,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(''),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    height: 45,
                    child: CommonButton(
                      text: "Save",
                      onConfirm: () {
                        if (addEditTaskController.isEdit) {
                          updateTask(
                            addEditTaskController.nameController.text
                                .toString(),
                            addEditTaskController.desciptionController.text
                                .toString(),
                          );
                        } else {
                          addTask(
                            addEditTaskController.nameController.text
                                .toString(),
                            addEditTaskController.desciptionController.text
                                .toString(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }

  // Add task
  void addTask(
    String name,
    String desc,
  ) {
    if (name != null && name.isEmpty) {
      addEditTaskController.isError = true;
      addEditTaskController.errorMsg = "Please enter name!";
    } else if (desc != null && desc.isEmpty) {
      addEditTaskController.isError = true;
      addEditTaskController.errorMsg = "Please enter description!";
    } else {
      repository.addTask(Task(
        taskName: name,
        taskDescription: desc,
        taskDate: DateFormat("dd-MM-yyyy")
            .format(addEditTaskController.selectedDate.value)
            .toString(),
        taskId: "",
        userId: uid,
      ));
      Get.to(TaskList());
    }
  }

  // Update Task
  void updateTask(
    String name,
    String desc,
  ) {
    if (name != null && name.isEmpty) {
      addEditTaskController.isError = true;
      addEditTaskController.errorMsg = "Please enter name!";
    } else if (desc != null && desc.isEmpty) {
      addEditTaskController.isError = true;
      addEditTaskController.errorMsg = "Please enter description!";
    } else {
      repository.updateTask(Task(
        taskName: name,
        taskDescription: desc,
        taskDate: DateFormat("dd-MM-yyyy")
            .format(addEditTaskController.selectedDate.value)
            .toString(),
        taskId: task.taskId,
        userId: uid,
      ));
      Get.to(TaskList());
    }
  }
}
