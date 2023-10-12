import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:yandex_mapkit_example/examples/widgets/control_button.dart';
import 'package:yandex_mapkit_example/examples/widgets/map_page.dart';

class PlacemarkMapObjectPage extends MapPage {
  const PlacemarkMapObjectPage({Key? key}) : super('Выбор квеста', key: key);
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
            width: 200,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text('Маршрут 1:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ControlButton(
                        onPressed: () async {
                          final List<Point> points = [
                            Point(latitude: 59.945933, longitude: 30.320045),
                            Point(latitude: 59.945933, longitude: 30.330045),
                            Point(latitude: 59.945933, longitude: 30.340045),
                            Point(latitude: 59.945933, longitude: 30.350045),
                          ];

                          for (var i = 0; i < points.length; i++) {
                            final mapObject = PlacemarkMapObject(
                              mapId: MapObjectId('placemark_$i'),
                              point: points[i],
                              onTap: (PlacemarkMapObject self, Point point) => print('Tapped me at $point'),
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
                              text: const PlacemarkText(
                                text: 'Point',
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
                        },
                        title: 'Проложить маршрут',
                      ),
                      ControlButton(
                        onPressed: () async {
                          setState(() {
                            mapObjects.clear();
                          });
                        },
                        title: 'Удалить маршрут',
                      ),
                    ],
                  ),






                  const Text('Маршрут 2:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ControlButton(
                        onPressed: () async {
                          final List<Point> points = [
                            Point(latitude: 59.955933, longitude: 30.320045),
                            Point(latitude: 59.965933, longitude: 30.330045),
                            Point(latitude: 59.975933, longitude: 30.340045),
                            Point(latitude: 59.985933, longitude: 30.350045),
                          ];

                          for (var i = 0; i < points.length; i++) {
                            final mapObject = PlacemarkMapObject(
                              mapId: MapObjectId('placemark_$i'),
                              point: points[i],
                              onTap: (PlacemarkMapObject self, Point point) => print('Tapped me at $point'),
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
                              text: const PlacemarkText(
                                text: 'Point',
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
                        },
                        title: 'Проложить маршрут',
                      ),
                      ControlButton(
                        onPressed: () async {
                          setState(() {
                            mapObjects.clear();
                          });
                        },
                        title: 'Удалить маршрут',
                      ),
                    ],
                  ),




                  const Text('Маршрут 3:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ControlButton(
                        onPressed: () async {
                          final List<Point> points = [
                            Point(latitude: 59.945933, longitude: 30.320045),
                            Point(latitude: 59.945933, longitude: 30.330045),
                            Point(latitude: 59.945933, longitude: 30.340045),
                            Point(latitude: 59.945933, longitude: 30.350045),
                          ];

                          for (var i = 0; i < points.length; i++) {
                            final mapObject = PlacemarkMapObject(
                              mapId: MapObjectId('placemark_$i'),
                              point: points[i],
                              onTap: (PlacemarkMapObject self, Point point) => print('Tapped me at $point'),
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
                              text: const PlacemarkText(
                                text: 'Point',
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
                        },
                        title: 'Проложить маршрут',
                      ),
                      ControlButton(
                        onPressed: () async {
                          setState(() {
                            mapObjects.clear();
                          });
                        },
                        title: 'Удалить маршрут',
                      ),
                    ],
                  ),






                ],
              ),
            ),
          // ),
        ),
      ],
    );
  }
}
