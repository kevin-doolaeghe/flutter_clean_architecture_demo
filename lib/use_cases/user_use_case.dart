import 'package:flutter_clean_architecture_demo/models/user.dart';
import 'package:flutter_clean_architecture_demo/view_models/login_view_model.dart';

abstract class ILoginRepository {
  Future<User?> login(String email, String password);
}

class UserUseCase extends ILoginUseCase {
  final ILoginRepository _repository;

  UserUseCase(this._repository);

  @override
  Future<User?> login(String email, String password) {
    return _repository.login(email, password);
  }
}
