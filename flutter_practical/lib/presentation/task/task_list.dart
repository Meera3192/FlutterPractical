import 'package:flutter/material.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:flutter_practical/presentation/task/add_edit_task.dart';
import 'package:flutter_practical/presentation/task/task_card.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_repository.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

// This class for display all the task in list
class TaskList extends StatelessWidget {
  final TaskRepository repository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/bg_nature.jpg",
                      ),
                      fit: BoxFit.fitWidth),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: /* Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [*/
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Your',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Things',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      DateFormat("MMM d, yyyy").format(DateTime.now()).toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Color(0x44100000),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '25',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Personal',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '15',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Business',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Row(
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 20.0,
                                      lineWidth: 3.0,
                                      percent: 65 / 100,
                                      backgroundColor: Colors.grey,
                                      //circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.blue[200],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '65% done',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: StreamBuilder<QuerySnapshot>(
                  stream: repository.getStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return _buildList(context, snapshot.data?.docs ?? []);
                  }),
            ),
          ],
        ),
      ),
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
