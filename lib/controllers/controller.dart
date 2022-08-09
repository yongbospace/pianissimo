import 'package:get/get_state_manager/get_state_manager.dart';

class Controller extends GetxController {
  int octave = 4;

  void octaveUp() {
    octave > 7 ? null : octave++;
    update();
  }

  void octaveDown() {
    octave < 1 ? null : octave--;
    update();
  }
}
