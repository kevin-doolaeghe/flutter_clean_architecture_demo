import 'package:flutter_clean_architecture_demo/features/login/presentation/views/login_view.dart';

class LoginViewModel extends ILoginViewModel {
  bool _isLoading = false;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  String? _errorMessage;
  String? _email;
  String? _password;

  @override
  bool get isLoading => _isLoading;
  @override
  String? get emailErrorMessage => _emailErrorMessage;
  @override
  String? get passwordErrorMessage => _passwordErrorMessage;
  @override
  String? get errorMessage => _errorMessage;

  @override
  void setEmail(String email) {
    _email = email;
  }

  @override
  void setPassword(String password) {
    _password = password;
  }

  @override
  void login() async {
    _isLoading = true;
    notifyListeners();

    final email = _email;
    final password = _password;

    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    final passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,}$');

    _emailErrorMessage = null;
    _passwordErrorMessage = null;
    if (email == null || email.isEmpty) {
      _emailErrorMessage = 'Email is required';
    } else if (!emailRegex.hasMatch(email)) {
      _emailErrorMessage = 'Invalid email';
    }
    if (password == null || password.isEmpty) {
      _passwordErrorMessage = 'Password is required';
    } else if (!passwordRegex.hasMatch(password)) {
      _passwordErrorMessage = 'Invalid password';
    }

    if (_emailErrorMessage == null && _passwordErrorMessage == null) {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));
      _errorMessage =
          password == 'password' ? 'Welcome $email' : 'Invalid credentials';
    }

    _isLoading = false;
    notifyListeners();
  }
}
