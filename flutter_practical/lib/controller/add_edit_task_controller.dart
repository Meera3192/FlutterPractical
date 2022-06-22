import 'package:flutter/material.dart';
import 'package:flutter_practical/model/task_master.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEditTaskController extends GetxController {

  late Task task = Task().obs as Task;
  late bool isEdit = false.obs as bool;
  var selectedDate = DateTime
      .now()
      .obs;

  RxString rxName = "".obs;
  RxString rxDescription = "".obs;
  RxString rxDate = "".obs;

  AddEditTaskController();

  late FocusNode focusName = FocusNode();
  late FocusNode focusDescription = FocusNode();
  late FocusNode focusDate = FocusNode();

  late TextEditingController dateController = TextEditingController();

  bool isError = false;
  String errorMsg = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

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
      rxName = RxString(task.taskName!);
      rxDescription = RxString(task.taskDescription!);
      rxDate = RxString(task.taskDate.toString());
     // selectedDate.value = DateFormat("dd-MM-yyyy").parse(task.taskDate.toString());

    } else {
      rxName = RxString("");
      rxDescription = RxString("");
      rxDate = RxString(DateFormat("dd-MM-yyyy").format(DateTime.now()));
     // selectedDate.value = DateTime.now();
    }
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
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
      rxDate.value = DateFormat("dd-MM-yyyy").format(selectedDate.value);
      print(rxDate.value);
    }
  }

  bool disableDate(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }
}