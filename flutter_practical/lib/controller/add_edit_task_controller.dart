import 'package:flutter/material.dart';
import 'package:flutter_practical/presentation/model/task_master.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEditTaskController extends GetxController {

  late Task task = Task().obs as Task;
  late bool isEdit = false.obs as bool;
  var selectedDate = DateTime
      .now()
      .obs;

  //AddEditTaskController({required this.task, this.isEdit = false});
  AddEditTaskController();


  late FocusNode focusName = FocusNode();
  late FocusNode focusDescription = FocusNode();
  late FocusNode focusDate = FocusNode();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController desciptionController = TextEditingController();
  late TextEditingController dateController = TextEditingController();

  bool isError = false;
  String errorMsg = "";


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    task = Task();
    isEdit = false;
    selectedDate.value = DateTime.now();
  }

  void initController(Task task, bool isEdit) {
    this.task = task;
    this.isEdit = isEdit;

    if (isEdit) {
      selectedDate.value = DateFormat("dd-MM-yyyy").parse(task.taskDate.toString());
      nameController.text =
      (task.taskName != null && task.taskName!.isNotEmpty)
          ? task.taskName.toString()
          : '';
      desciptionController.text = (task.taskDescription != null &&
          task.taskDescription!.isNotEmpty)
          ? task.taskDescription!
          : '';
    } else {
      //selectedDate.value = DateFormat("dd-MM-yyyy").parse(DateFormat("dd-MM-yyyy").format(DateTime.now()));
      nameController.text = "";
      desciptionController.text = "";
    }
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        //initialEntryMode: DatePickerEntryMode.input,
        // initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select DOB',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Month/Date/Year',
        selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  bool disableDate(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }
}