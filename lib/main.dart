import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/features/login/presentation/view_models/login_view_model.dart';
import 'package:flutter_clean_architecture_demo/features/login/presentation/views/login_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: LoginView(viewModel: LoginViewModel()),
    );
  }
}
