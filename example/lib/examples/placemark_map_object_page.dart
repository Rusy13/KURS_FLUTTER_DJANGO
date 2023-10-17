import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:yandex_mapkit_example/examples/widgets/control_button.dart';
import 'package:yandex_mapkit_example/examples/widgets/map_page.dart';

class PlacemarkMapObjectPage extends MapPage {
  final List<Map<String, dynamic>> pointsData;

  PlacemarkMapObjectPage({Key? key, required this.pointsData}) : super('Выбор квеста1', key: key);

  @override
  Widget build(BuildContext context) {
    return _PlacemarkMapObjectExample(pointsData: pointsData);
  }
}

class _PlacemarkMapObjectExample extends StatefulWidget {
  final List<Map<String, dynamic>> pointsData;

  _PlacemarkMapObjectExample({required this.pointsData});

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


  // Метод для отображения плашки при нажатии на метку
  void _showPlacemarkInfo(BuildContext context, String name, String description, String hint, String answer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(description),
              SizedBox(height: 8.0),
              Text('Подсказка: $hint'),
              Text('Ответ: $answer'),
            ],
          ),
        );
      },
    );
  }



  @override
  void initState() {
    super.initState();
    _addPlacemarkMapObjectsOnLoad();
  }

  Future<void> _addPlacemarkMapObjectsOnLoad() async {
    for (var i = 0; i < widget.pointsData.length; i++) {
      final pointData = widget.pointsData[i];
      final latitude = pointData['latitude'] as double;
      final longitude = pointData['longitude'] as double;
      final name = pointData['name'] as String;
      final description = pointData['description'] as String;
      final hint = pointData['hint'] as String;
      final answer = pointData['answer'] as String;

      print(latitude);
      print(longitude);
      print(name);
      print(description);
      print(hint);
      print(answer);


      final mapObject = PlacemarkMapObject(
        mapId: MapObjectId('placemark_$i'),
        point: Point(latitude: latitude, longitude: longitude),
        onTap: (PlacemarkMapObject self, Point point) {
            _showPlacemarkInfo(context, name, description, hint, answer);},
        opacity: 0.7,
        direction: 0,
        isDraggable: true,
        onDragStart: (_) => print('Drag start'),
        onDrag: (_, Point point) => print('Drag at point $point'),
        onDragEnd: (_) => print('Drag end'),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/assets/route_end.png'),
          rotationType: RotationType.rotate,
        )),
        text: PlacemarkText(
          text: name,
          style: PlacemarkTextStyle(
            placement: TextStylePlacement.top,
            color: Colors.amber,
            outlineColor: Colors.black,
          ),
        ),
      );

      setState(() {
        mapObjects.add(mapObject);
      });
    }
  }

  Widget build(BuildContext context) {
    print('Точки для маршрута: ${widget.pointsData}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: YandexMap(
              mapObjects: mapObjects,
            ),
          ),
        ),
        const SizedBox(height: 0),





      ],
    );
  }
}
