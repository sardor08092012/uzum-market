import 'package:flutter/material.dart';
import 'package:uzum_market/src/core/router/app_router.dart';
import 'package:uzum_market/src/core/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uzum Market',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}