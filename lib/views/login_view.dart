import 'package:flutter/material.dart';

abstract class ILoginViewModel extends ChangeNotifier {
  bool get isLoading;
  String? get emailErrorMessage;
  String? get passwordErrorMessage;
  String? get errorMessage;

  void setEmail(String email);
  void setPassword(String password);
  void login();
}

class LoginView extends StatelessWidget {
  final ILoginViewModel viewModel;

  const LoginView(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedBuilder(
            animation: viewModel,
            builder: (context, child) {
              final emailErrorMessage = viewModel.emailErrorMessage;
              final passwordErrorMessage = viewModel.passwordErrorMessage;
              final errorMessage = viewModel.errorMessage;

              return Column(
                children: [
                  TextFormField(
                    onChanged: viewModel.setEmail,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [
                      AutofillHints.username,
                      AutofillHints.email,
                    ],
                    decoration: InputDecoration(
                        labelText: 'Email', errorText: emailErrorMessage),
                  ),
                  TextFormField(
                    onChanged: viewModel.setPassword,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                        labelText: 'Password', errorText: passwordErrorMessage),
                  ),
                  const SizedBox(height: 12),
                  if (viewModel.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Center(
                      child: ElevatedButton(
                          onPressed: viewModel.login,
                          child: const Text("Sign in")),
                    ),
                  const SizedBox(height: 8),
                  if (errorMessage != null) Text(errorMessage),
                ],
              );
            }),
      ),
    );
  }
}
