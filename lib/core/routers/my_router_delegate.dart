import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/core/routers/my_route_information.dart';
import 'package:flutter_clean_architecture_demo/data_sources/user_data_source.dart';
import 'package:flutter_clean_architecture_demo/models/user.dart';
import 'package:flutter_clean_architecture_demo/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_demo/use_cases/user_use_case.dart';
import 'package:flutter_clean_architecture_demo/view_models/home_view_model.dart';
import 'package:flutter_clean_architecture_demo/view_models/login_view_model.dart';
import 'package:flutter_clean_architecture_demo/views/home_view.dart';
import 'package:flutter_clean_architecture_demo/views/login_view.dart';

class MyRouterDelegate extends RouterDelegate<MyRouteInformation>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin
    implements ILoginRouter, IHomeRouter {
  User? currentUser;
  bool shouldDisplaySettings = false;

  MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    final List<Page> pages = buildPages(context);

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onDidRemovePage: (page) {
        pages.remove(page);
      },
    );
  }

  List<Page> buildPages(BuildContext context) {
    final List<Page> pages = [];

    if (currentUser == null) {
      pages.add(MaterialPage(
        key: const ValueKey('LoginPage'),
        child: LoginView(
          LoginViewModel(
            UserUseCase(
              UserRepository(
                UserDataSource(),
              ),
            ),
            this,
          ),
        ),
      ));
    } else {
      pages.add(MaterialPage(
        key: const ValueKey('HomePage'),
        child: HomeView(HomeViewModel(this)),
      ));

      if (shouldDisplaySettings) {
        pages.add(MaterialPage(
          key: const ValueKey('SettingsPage'),
          child: Container(), // SettingsPage(),
        ));
      }
    }

    return pages;
  }

  @override
  MyRouteInformation? get currentConfiguration =>
      currentUser == null ? null : MyRouteInformation(userId: currentUser?.id);

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(MyRouteInformation configuration) async {}

  @override
  void setUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  @override
  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
