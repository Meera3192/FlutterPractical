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
import 'package:flutter_practical/widget/common_text_input.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Class for add and edit task
class AddEditTask extends StatelessWidget {
  Task task = Task();
  bool isEdit = false;

  AddEditTask({Key? key, required this.task, this.isEdit = false});

  final AddEditTaskController addEditTaskController = Get.put(AddEditTaskController());

  final TaskRepository repository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    addEditTaskController.initController(task, isEdit);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Colors.indigo[400],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.blue),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(
                        "Add New things",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle, color: Colors.blue,),
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
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  IconButton(
                    icon: const Icon(Icons.blur_circular, color: Colors.blue,size: 50,),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextInput(onChanged: (value){
                    addEditTaskController.rxName=RxString(value);
                  }, labelText: "Name",value: addEditTaskController.rxName.value,),
                  SizedBox(
                    height: 30,
                  ),
                  TextInput(onChanged: (value){
                    addEditTaskController.rxDescription=RxString(value);
                  }, labelText: "Description",value: addEditTaskController.rxDescription.value),
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
                                        color: Colors.white,
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
                          () => Text(addEditTaskController.rxDate.value,
                            style: TextStyle(fontSize: 18, color: Colors.white,),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.white,),
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
                            addEditTaskController.rxName.value,addEditTaskController.rxDescription.value,
                          );
                        } else {
                          addTask(
                            addEditTaskController.rxName.value,addEditTaskController.rxDescription.value,
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
        taskDate:  DateFormat("dd-MM-yyyy").format(DateFormat("dd-MM-yyyy").parse(addEditTaskController.rxDate.value)),
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
        taskDate: DateFormat("dd-MM-yyyy").format(DateFormat("dd-MM-yyyy").parse(addEditTaskController.rxDate.value)),
        taskId: task.taskId,
        userId: uid,
      ));
      Get.to(TaskList());
    }
  }
}
