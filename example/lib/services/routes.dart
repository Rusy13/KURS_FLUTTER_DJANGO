import 'package:flutter/material.dart';
import '../examples/placemark_map_object_page.dart';
import '../examples/views/choise_kvest.dart';
import '../examples/views/homepage.dart';
import '../examples/views/levels.dart';
// import '../examples/views/map.dart';

import '../main.dart';


final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomePage(),
  '/choise': (context) => RoutesListPage(routes as List<Map<String, dynamic>>),
  // '/main': (context) => const PlacemarkMapObjectPage(),
  '/placemark_map_object': (context) => PlacemarkMapObjectPage(),
};