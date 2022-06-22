
import 'package:flutter/material.dart';
import 'package:flutter_practical/controller/login_controller.dart';
import 'package:flutter_practical/presentation/login/user_details.dart';
import 'package:flutter_practical/presentation/login/sign_in.dart';
import 'package:flutter_practical/presentation/task/task_list.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
 late final LoginController loginController ;
  @override
  Widget build(BuildContext context) {
    loginController = Get.put(LoginController());
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 0,
        side: BorderSide(color: Colors.grey),
      ),
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Get.to(TaskList(),);
          }
        });
      },

      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
