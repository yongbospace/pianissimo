import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:get/get.dart';
import 'package:pianissimo/controllers/controller.dart';

enum KeyColors { white, black }

class PianoKey extends StatelessWidget {
  final KeyColors color;
  final double width;
  final int midiNote;
  final FlutterMidi flutterMidi;
  final bool? isCenter;

  const PianoKey.white({
    Key? key,
    required this.width,
    required this.midiNote,
    required this.flutterMidi,
    this.isCenter,
  })  : color = KeyColors.white,
        super(key: key);

  const PianoKey.black({
    Key? key,
    required this.width,
    required this.midiNote,
    required this.flutterMidi,
    this.isCenter,
  })  : color = KeyColors.black,
        super(key: key);

  playNote() {
    flutterMidi.playMidiNote(midi: midiNote);
  }

  stopNote() async {
    await Future.delayed(const Duration(milliseconds: 150));
    flutterMidi.stopMidiNote(midi: midiNote);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => playNote(),
      onTapUp: (_) => stopNote(),
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        height: MediaQuery.of(context).size.height,
        width: width,
        decoration: BoxDecoration(
          color: color == KeyColors.white ? Colors.white : Colors.black,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: color == KeyColors.white
              ? const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                )
              : const BorderRadius.vertical(
                  bottom: Radius.circular(6),
                ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: showCenter(),
        ),
      ),
    );
  }

  showCenter() {
    if (isCenter == null) {
      return null;
    }
    if (!isCenter!) {
      return null;
    }
    return GetBuilder<Controller>(
        init: Controller(),
        builder: (_) {
          return Text(
            "C${Get.find<Controller>().octave}",
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          );
        });
  }
}
