import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 1],
              colors: [Colors.white, Color.fromARGB(255, 143, 138, 138)],
            )),
            child: Scaffold(
              // appBar: AppBar(
              //   title: const Text('Login'),
              // ),
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(letterSpacing: 1.5, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 14, vertical: 12))),
                      onPressed: () {
                        _authController.signInWithGoogle();
                      },
                      // style: ElevatedButton.styleFrom(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      //   foregroundColor: Colors.black,
                      //   backgroundColor: Colors.white,
                      //   side: const BorderSide(color: Colors.grey),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/google.png",
                              height: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Sign in with Google",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_authController.isLoading.value)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (_authController.isLoading.value)
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
