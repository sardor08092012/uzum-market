import 'package:flutter/material.dart';
import 'package:uzum_market/src/features/home/screens/home_screen.dart';
import 'package:uzum_market/src/features/like/screens/like_screen.dart';
import 'package:uzum_market/src/features/profle/screens/profile_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case '/like':
        return MaterialPageRoute(builder: (context) => LikeScreen());
      default:
        return MaterialPageRoute(builder: (context) => NoPageWidget());
    }
  }
}

class NoPageWidget extends StatelessWidget {
  const NoPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
        },
        icon: Icon(Icons.home),
      ),
      body: Center(child: Text('404 not found')),
    );
  }
}
