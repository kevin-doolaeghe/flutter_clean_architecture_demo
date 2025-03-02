import 'package:flutter/material.dart';

abstract class IHomeViewModel extends ChangeNotifier {
  void logout();
}

class HomeView extends StatelessWidget {
  final IHomeViewModel viewModel;

  const HomeView(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              return Column(
                children: [
                  const Text('Welcome!'),
                  Center(
                    child: ElevatedButton(
                        onPressed: viewModel.logout,
                        child: const Text("Logout")),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
