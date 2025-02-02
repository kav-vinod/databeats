/*
import 'package:auto_route/auto_route.dart';
import 'package:databeats/StartPage.dart';
import 'package:flutter/foundation.dart';
import 'package:databeats/LoadingPage.dart';
import 'package:databeats/UserHomePage.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: StartRoute.page, path: '/', initial: true),
    AutoRoute(page: LoadingRoute.page, path: '/loading'),
    AutoRoute(page: UserHomeRoute.page, path: '/userhome'),
  ];

  //auto_route registers itself as the deep link handler with the app
  //deepLinkBuilder function automatically called by auto_route when app is opened with a deep link (like in the case with /callback?code='insert code here')
  //process: deep link opened, OS passes it to flutter, flutter passes it to auto_route, auto_route calls deepLinkBuilder, deepLinkBuilder returns a DeepLink object, auto_route navigates to the page specified in the DeepLink object
  //using MaterialApp.router w/ auto_route means that it listens for deep links and the deepLinkBuilder function is automatically called when a deep link is opened
  @override
  DeepLink deepLinkBuilder(Uri uri) {
    print("Received URI: $uri"); // Debug print
    if (uri.queryParameters.containsKey('code')) {
      return DeepLink([LoadingRoute(title: "Databeats", authCode: uri.queryParameters["code"])]);
    }
  return DeepLink([]);
  }
}
*/