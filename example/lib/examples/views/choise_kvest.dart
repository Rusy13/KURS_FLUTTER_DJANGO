import 'package:flutter/material.dart';

import '../../services/network_manager.dart';

class RoutesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> routes; // Список маршрутов, который нужно передать

  RoutesListPage(this.routes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список маршрутов'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return ListTile(
            title: Text(route['name']),
            onTap: () async {
              final routeId = route['id'];
              final points = await NetworkManager().getPointsForRoute(routeId);
              print('Точки для маршрута ${route['name']}: $points');
              print('Отправляю точки: $points');
              Navigator.of(context).pushNamed('/placemark_map_object', arguments: points);


            },

          );
        },
      ),
    );
  }
}