import 'package:flutter/material.dart';
import '../../services/network_manager.dart';
import 'choise_kvest.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final networkManager = NetworkManager();

                try {
                  final routes = await networkManager.getRoutes();

                  for (final route in routes) {
                    final routeId = route['id'];
                    final points = await networkManager.getPointsForRoute(routeId);
                    print('Точки для маршрута ${route['name']}: $points');
                  }

                  // После завершения загрузки данных
                  // Navigator.of(context).pushNamed('/test');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RoutesListPage(routes),
                  ));
                } catch (e) {
                  print('Ошибка при загрузке данных: $e');
                }
              },
              tooltip: 'Main',
              child: const Icon(Icons.airplanemode_on),
            ),
            const SizedBox(height: 16), // Добавьте отступ между кнопкой и текстом
            const Text(
              'Go to main',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
