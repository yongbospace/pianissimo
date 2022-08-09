import 'package:flutter/material.dart';
import 'package:pianissimo/controllers/controller.dart';
import 'package:pianissimo/screens/piano.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                controller.octaveDown();
              },
              icon: const Icon(Icons.keyboard_arrow_left, size: 30),
            ),
            IconButton(
              onPressed: () {
                controller.octaveUp();
              },
              icon: const Icon(Icons.keyboard_arrow_right, size: 30),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: const Text(
          "Pianissimo",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
      body: GetBuilder<Controller>(builder: (_) => Piano()),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black,
        elevation: 6,
        child: (SizedBox()),
      ),
    );
  }
}
