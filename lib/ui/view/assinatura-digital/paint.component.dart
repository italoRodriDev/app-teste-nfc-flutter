import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

// -> Precisa da biblioteca  image: ^3.0.1

class PaintComponent extends StatefulWidget {
  @override
  _PaintComponentState createState() => _PaintComponentState();
}

class _PaintComponentState extends State<PaintComponent> {
  List<List<Offset>> strokes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.check),
                onPressed: () {
                  _saveSignature();
                }),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                buildToolbar(),
                const SizedBox(height: 10),
                const Text('Faça sua assinatura digital.'),
                const SizedBox(height: 5),
                Expanded(
                    child: Center(
                        child: Container(
                            width: 160,
                            height: 480,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: GestureDetector(
                              onPanStart: (details) {
                                strokes.add([details.localPosition]);
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  strokes.last.add(details.localPosition);
                                });
                              },
                              onPanEnd: (details) {
                                // Adicione uma lista vazia para indicar o fim do gesto
                                strokes.add([]);
                              },
                              child: CustomPaint(
                                painter: SignaturePainter(strokes),
                              ),
                            ))))
              ],
            )));
  }

  Future<void> _saveSignature() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }

    final picture = recorder.endRecording();
    final imgSignature = await picture.toImage(300, 150);
    final byteData = await imgSignature.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final pngBytes = byteData!.buffer.asUint8List();

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;

    final File file = File('$appDocPath/signature.png');
    await file.writeAsBytes(pngBytes);

    print('Assinatura salva em: ${file.path}');
  }

  Widget buildToolbar() {
    return AppBar(
      title: Text('Assinatura Digital', style: TextStyle(fontSize: 18),),
      actions: [
        IconButton(
          icon: Icon(Icons.redo),
          onPressed: () {
            // Adicione a lógica desejada para o botão "Refazer"
            strokes = [];
            setState(() {
              
            });
          },
        ),
      ],
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;

  SignaturePainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
