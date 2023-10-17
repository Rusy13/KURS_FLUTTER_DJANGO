import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:yandex_mapkit_example/examples/widgets/control_button.dart';
import 'package:yandex_mapkit_example/examples/widgets/map_page.dart';

class PlacemarkMapObjectPage extends MapPage {
  const PlacemarkMapObjectPage({Key? key}) : super('Выбор квеста1', key: key);
  @override
  Widget build(BuildContext context) {
    return _PlacemarkMapObjectExample();
  }
}

class _PlacemarkMapObjectExample extends StatefulWidget {
  @override
  _PlacemarkMapObjectExampleState createState() => _PlacemarkMapObjectExampleState();
}

class _PlacemarkMapObjectExampleState extends State<_PlacemarkMapObjectExample> {
  final List<MapObject> mapObjects = [];

  final MapObjectId mapObjectWithDynamicIconId = const MapObjectId('dynamic_icon_placemark');
  final MapObjectId mapObjectWithCompositeIconId = const MapObjectId('composite_icon_placemark');

  Future<Uint8List> _rawPlacemarkImage() async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(50, 50);
    final fillPaint = Paint()
      ..color = Colors.blue[100]!
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const radius = 20.0;

    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);

    final image = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // ширина карты
            height: MediaQuery.of(context).size.height * 0.5,
            child: YandexMap(
              mapObjects: mapObjects,
            ),
          ),
        ),
        const SizedBox(height: 15),





        Container(
          // child: Container(
          height: MediaQuery.of(context).size.width * 0.5,

        ),
      ],
    );
  }
}