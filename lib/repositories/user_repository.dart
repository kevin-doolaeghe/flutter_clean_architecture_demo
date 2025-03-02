import 'package:flutter_clean_architecture_demo/models/user.dart';
import 'package:flutter_clean_architecture_demo/use_cases/user_use_case.dart';

abstract class ILoginDataSource {
  Future<bool> login(String email, String password);
}

class UserRepository extends ILoginRepository {
  final ILoginDataSource _dataSource;

  UserRepository(this._dataSource);

  @override
  Future<User?> login(String email, String password) async {
    final isLoggedIn = await _dataSource.login(email, password);
    User? user;
    if (isLoggedIn) {
      user = User(id: "23", email: email);
    }
    return Future.value(user);
  }
}
