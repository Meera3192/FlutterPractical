import 'package:flutter_practical/presentation/login/sign_in.dart';
import 'package:flutter_practical/presentation/task/task_list.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    signInWithGoogle().then((result) {
      if (result != null) {
        Get.to(TaskList(),);
      }
    });
  }
}