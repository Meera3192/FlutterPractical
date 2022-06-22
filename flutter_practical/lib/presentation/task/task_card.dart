import 'package:flutter/material.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:flutter_practical/presentation/task/add_edit_task.dart';
import 'package:flutter_practical/presentation/task/task_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// This class for single task in card
class TaskCard extends StatelessWidget {
  Task task;
  final TaskRepository repository = TaskRepository();

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.taskName.toString(),
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Color(0xff1f3241),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                task.taskDescription.toString(),
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat("MMM d, yyyy")
                              .format(DateFormat("dd-MM-yyyy")
                                  .parse(task.taskDate.toString()))
                              .toString(),
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: Color(0xff1f3241),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Show Snackbar',
                          onPressed: () {
                            Get.to(
                              AddEditTask(
                                task: task,
                                isEdit: true,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Show Snackbar',
                          onPressed: () {
                            repository.deleteTask(task);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
