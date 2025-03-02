import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/core/routers/my_route_information.dart';

class MyRouteInformationParser
    extends RouteInformationParser<MyRouteInformation> {
  @override
  Future<MyRouteInformation> parseRouteInformation(
      RouteInformation routeInformation) {
    final Uri uri = routeInformation.uri;

    final String? userId;
    if (uri.pathSegments.length >= 2) {
      userId = uri.pathSegments[1];
    } else {
      userId = null;
    }

    return Future.value(MyRouteInformation(userId: userId));
  }

  @override
  RouteInformation? restoreRouteInformation(MyRouteInformation configuration) {
    String location = "/";

    final String? userId = configuration.userId;
    if (userId != null) {
      location = "${location}user/$userId";
    }

    return RouteInformation(uri: Uri.parse(location));
  }
}
