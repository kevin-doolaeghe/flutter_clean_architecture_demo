import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/core/routers/my_route_information_parser.dart';
import 'package:flutter_clean_architecture_demo/core/routers/my_router_delegate.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _routerDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
