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

class LoginView extends StatefulWidget {
  final ILoginViewModel viewModel;

  const LoginView({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void _onLoginButtonPressed() {
    widget.viewModel.login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedBuilder(
            animation: widget.viewModel,
            builder: (context, child) {
              final emailErrorMessage = widget.viewModel.emailErrorMessage;
              final passwordErrorMessage =
                  widget.viewModel.passwordErrorMessage;
              final errorMessage = widget.viewModel.errorMessage;

              return Column(
                children: [
                  TextFormField(
                    onChanged: widget.viewModel.setEmail,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [
                      AutofillHints.username,
                      AutofillHints.email,
                    ],
                    decoration: InputDecoration(
                        labelText: 'Email', errorText: emailErrorMessage),
                  ),
                  TextFormField(
                    onChanged: widget.viewModel.setPassword,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                        labelText: 'Password', errorText: passwordErrorMessage),
                  ),
                  const SizedBox(height: 12),
                  if (widget.viewModel.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Center(
                      child: ElevatedButton(
                          onPressed: _onLoginButtonPressed,
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
