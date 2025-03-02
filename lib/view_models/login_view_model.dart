import 'package:flutter_clean_architecture_demo/models/user.dart';
import 'package:flutter_clean_architecture_demo/views/login_view.dart';

abstract class ILoginRouter {
  void setUser(User user);
}

abstract class ILoginUseCase {
  Future<User?> login(String email, String password);
}

class LoginViewModel extends ILoginViewModel {
  final ILoginUseCase _useCase;
  final ILoginRouter _router;

  LoginViewModel(this._useCase, this._router);

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
    _emailErrorMessage = null;
  }

  @override
  void setPassword(String password) {
    _password = password;
    _passwordErrorMessage = null;
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
      final user = await _useCase.login(email!, password!);
      if (user != null) {
        _router.setUser(user);
        _errorMessage = null;
      } else {
        _errorMessage = 'Invalid credentials';
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
