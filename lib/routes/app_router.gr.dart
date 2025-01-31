// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [LoadingPage]
class LoadingRoute extends PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    Key? key,
    required String? authCode,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         LoadingRoute.name,
         args: LoadingRouteArgs(key: key, authCode: authCode, title: title),
         initialChildren: children,
       );

  static const String name = 'LoadingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoadingRouteArgs>();
      return LoadingPage(
        key: args.key,
        authCode: args.authCode,
        title: args.title,
      );
    },
  );
}

class LoadingRouteArgs {
  const LoadingRouteArgs({
    this.key,
    required this.authCode,
    required this.title,
  });

  final Key? key;

  final String? authCode;

  final String title;

  @override
  String toString() {
    return 'LoadingRouteArgs{key: $key, authCode: $authCode, title: $title}';
  }
}

/// generated route for
/// [StartPage]
class StartRoute extends PageRouteInfo<StartRouteArgs> {
  StartRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        StartRoute.name,
        args: StartRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'StartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StartRouteArgs>(
        orElse: () => const StartRouteArgs(),
      );
      return StartPage(key: args.key);
    },
  );
}

class StartRouteArgs {
  const StartRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'StartRouteArgs{key: $key}';
  }
}

/// generated route for
/// [UserHomePage]
class UserHomeRoute extends PageRouteInfo<UserHomeRouteArgs> {
  UserHomeRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         UserHomeRoute.name,
         args: UserHomeRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'UserHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserHomeRouteArgs>();
      return UserHomePage(key: args.key, title: args.title);
    },
  );
}

class UserHomeRouteArgs {
  const UserHomeRouteArgs({this.key, required this.title});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'UserHomeRouteArgs{key: $key, title: $title}';
  }
}
