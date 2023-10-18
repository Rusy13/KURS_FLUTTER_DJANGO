import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:yandex_mapkit_example/examples/views/map.dart';

class PlacemarkInfoSheet extends StatefulWidget {
  final String description;
  final String hint;
  final String answer;
  final Function(bool) onAnswer;

  PlacemarkInfoSheet({
    required this.description,
    required this.hint,
    required this.answer,
    required this.onAnswer,
  });

  @override
  _PlacemarkInfoSheetState createState() => _PlacemarkInfoSheetState();
}

class _PlacemarkInfoSheetState extends State<PlacemarkInfoSheet> {
  TextEditingController _answerController = TextEditingController();
  int incorrectAttempts = 0;

  void _showHint() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Подсказка'),
          content: Text(widget.hint),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Описание: ${widget.description}'),
          SizedBox(height: 8.0),
          // Text('Попыток: $incorrectAttempts / 3'),
          // SizedBox(height: 8.0),
          TextField(
            controller: _answerController,
            decoration: InputDecoration(labelText: 'Введите ответ'),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              final userAnswer = _answerController.text;
              if (userAnswer == widget.answer) {
                widget.onAnswer(true); // Correct answer, remove the marker
                Navigator.pop(context); // Close the bottom sheet on a correct answer
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Ответ верный! Двигайся к следующей локации'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Попробуй еще'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
                incorrectAttempts++;
                if (incorrectAttempts >= 3) {
                  _showHint();
                  incorrectAttempts = 0; // Reset the incorrect attempts count
                }
              }
            },
            child: Text('Проверить ответ'),
          ),
        ],
      ),
    );
  }
}

class PlacemarkMapObjectPage extends MapPage {
  final List<Map<String, dynamic>> pointsData;

  PlacemarkMapObjectPage({Key? key, required this.pointsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PlacemarkMapObjectExample(pointsData: pointsData);
  }
}

class _PlacemarkMapObjectExample extends StatefulWidget {
  final List<Map<String, dynamic>> pointsData;

  _PlacemarkMapObjectExample({required this.pointsData});

  @override
  _PlacemarkMapObjectExampleState createState() =>
      _PlacemarkMapObjectExampleState();
}

class _PlacemarkMapObjectExampleState extends State<_PlacemarkMapObjectExample> {
  final List<MapObject> mapObjects = [];
  late YandexMapController controller;

  void _showPlacemarkInfo(
      BuildContext context, int markerIndex, String name, String description, String hint, String answer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PlacemarkInfoSheet(
          description: description,
          hint: hint,
          answer: answer,
          onAnswer: (isCorrect) {
            if (isCorrect) {
              setState(() {
                mapObjects.removeAt(markerIndex);
              });
            }
          },
        );
      },
    );
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

      final mapObject = PlacemarkMapObject(
        mapId: MapObjectId('placemark_$i'),
        point: Point(latitude: latitude, longitude: longitude),
        onTap: (PlacemarkMapObject self, Point point) {
          _showPlacemarkInfo(context, i, name, description, hint, answer);
        },
        opacity: 0.7,
        direction: 0,
        isDraggable: true,
        onDragStart: (_) => print('Drag start'),
        onDrag: (_, Point point) => print('Drag at point $point'),
        onDragEnd: (_) => print('Drag end'),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
              'lib/assets/route_end.png'),
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

  @override
  void initState() {
    super.initState();
    _addPlacemarkMapObjectsOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    final Point _point = Point(
      latitude: widget.pointsData[0]['latitude'] as double,
      longitude: widget.pointsData[0]['longitude'] as double,
    );

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
              onMapCreated: (YandexMapController c) {
                controller = c;
                // Set the initial camera position when the map is created
                controller.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: _point),
                ));
              },
            ),
          ),
        ),
        const SizedBox(height: 0),
      ],
    );
  }
}
