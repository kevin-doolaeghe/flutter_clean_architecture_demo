abstract class ILoginDataSource {
  Future<bool> login(String email, String password);
}

class LoginDataSource extends ILoginDataSource {
  @override
  Future<bool> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
