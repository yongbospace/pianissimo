import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pianissimo/components/piano_key.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:pianissimo/controllers/controller.dart';

class Piano extends StatefulWidget {
  const Piano({Key? key}) : super(key: key);

  @override
  State<Piano> createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  Controller controller = Get.put(Controller());

  get octaveStartingNote => ((controller.octave + 1) * 12) % 128;

  final List<int> whiteNotes = List.generate(25, (index) => index)
    ..removeWhere((e) => [1, 3, 6, 8, 10].contains(e % 12));

  final List<int> blackNotes = List.generate(25, (index) => index)
    ..removeWhere((e) => [0, 2, 4, 5, 7, 9, 11, 12].contains(e % 12));

  final FlutterMidi flutterMidi = FlutterMidi();

  @override
  void initState() {
    setupMIDIPlugin();
    super.initState();
  }

  Future<void> setupMIDIPlugin() async {
    flutterMidi.unmute();
    ByteData byte = await rootBundle.load("assets/sf2/Piano.SF2");
    flutterMidi.prepare(sf2: byte);
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final whiteKeySize = constraints.maxWidth / whiteNotes.length;
        final blackKeySize = whiteKeySize / 2;
        return Stack(
          children: [
            _buildWhiteKeys(whiteKeySize),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 100,
              top: 0.0,
              child: _buildBlackKeys(
                constraints.maxHeight,
                blackKeySize,
                whiteKeySize,
              ),
            )
          ],
        );
      },
    );
  }

  _buildWhiteKeys(double whiteKeySize) {
    return Row(
      children: whiteNotes
          .map(
            (e) => PianoKey.white(
              width: whiteKeySize,
              midiNote: octaveStartingNote + e,
              flutterMidi: flutterMidi,
              isCenter: e == 12 ? true : false,
            ),
          )
          .toList(),
    );
  }

  _buildBlackKeys(
    double pianoHeight,
    double blackKeySize,
    double whiteKeySize,
  ) {
    return Row(
      children: [
        ...blackNotes
            .map(
              (e) => Row(
                children: [
                  SizedBox(
                      width: e == blackNotes[0]
                          ? whiteKeySize - blackKeySize / 2
                          : e % 12 == 1 || e % 12 == 6
                              ? whiteKeySize * 2 - blackKeySize
                              : whiteKeySize - blackKeySize),
                  PianoKey.black(
                    width: blackKeySize,
                    midiNote: octaveStartingNote + e,
                    flutterMidi: flutterMidi,
                  ),
                ],
              ),
            )
            .toList()
      ],
    );
  }
}
