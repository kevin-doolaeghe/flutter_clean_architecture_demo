import 'package:flutter_clean_architecture_demo/repositories/user_repository.dart';

class UserDataSource extends ILoginDataSource {
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(true);
  }
}
