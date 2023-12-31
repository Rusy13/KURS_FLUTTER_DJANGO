import 'package:flutter/material.dart';
import '../examples/map_controls_page.dart';
import '../examples/placemark_map_object_page.dart';
import '../examples/views/choise_kvest.dart';
import '../examples/views/homepage.dart';
import '../examples/views/levels.dart';
// import '../examples/views/map.dart';
import '../main.dart';
final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomePage(),
  '/test': (context) => const MapControlsPage(),
  '/choise': (context) => RoutesListPage(routes as List<Map<String, dynamic>>),
  '/placemark_map_object': (context) {
    final points = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;
    return PlacemarkMapObjectPage(pointsData: points);

  },


};