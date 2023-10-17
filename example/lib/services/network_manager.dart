import 'package:dio/dio.dart';
// import 'package:flutter_pr1/repositories/models/coindesk.dart';
// import 'package:example/lib/services/network_manager.dart';

class NetworkManager {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Map<String, dynamic>>> getRoutes() async {
    try {
      final response = await Dio().get('$baseUrl/routes/?format=json');
      if (response.statusCode == 200) {
        final routes = List<Map<String, dynamic>>.from(response.data);
        return routes;
      } else {
        throw Exception('Failed to load routes');
      }
    } catch (e) {
      throw Exception('Failed to load routes: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> getPointsForRoute(int routeId) async {
    try {
      final response = await Dio().get('$baseUrl/routes/$routeId/points/list/');
      if (response.statusCode == 200) {
        final points = List<Map<String, dynamic>>.from(response.data);
        return points;
      } else {
        throw Exception('Failed to load points for route $routeId');
      }
    } catch (e) {
      throw Exception('Failed to load points: $e');
    }
  }
}

void main() async {
  final networkManager = NetworkManager();

  try {
    final routes = await networkManager.getRoutes();

    for (final route in routes) {
      final routeId = route['id'];
      final points = await networkManager.getPointsForRoute(routeId);
      print('Точки для маршрута ${route['name']}: $points');
    }
  } catch (e) {
    print('Ошибка: $e');
  }
}
