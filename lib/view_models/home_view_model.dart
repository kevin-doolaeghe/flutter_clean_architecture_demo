import 'package:flutter_clean_architecture_demo/views/home_view.dart';

abstract class IHomeRouter {
  void logout();
}

class HomeViewModel extends IHomeViewModel {
  final IHomeRouter _router;

  HomeViewModel(this._router);

  @override
  void logout() {
    _router.logout();
  }
}
