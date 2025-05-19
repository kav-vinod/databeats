// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DataPage]
class DataRoute extends PageRouteInfo<DataRouteArgs> {
  DataRoute({Key? key, required String title, List<PageRouteInfo>? children})
    : super(
        DataRoute.name,
        args: DataRouteArgs(key: key, title: title),
        initialChildren: children,
      );

  static const String name = 'DataRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DataRouteArgs>();
      return DataPage(key: args.key, title: args.title);
    },
  );
}

class DataRouteArgs {
  const DataRouteArgs({this.key, required this.title});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'DataRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [FriendComparePage]
class FriendCompareRoute extends PageRouteInfo<FriendCompareRouteArgs> {
  FriendCompareRoute({
    dynamic friendname,
    dynamic title,
    List<PageRouteInfo>? children,
  }) : super(
         FriendCompareRoute.name,
         args: FriendCompareRouteArgs(friendname: friendname, title: title),
         initialChildren: children,
       );

  static const String name = 'FriendCompareRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FriendCompareRouteArgs>(
        orElse: () => const FriendCompareRouteArgs(),
      );
      return FriendComparePage(friendname: args.friendname, title: args.title);
    },
  );
}

class FriendCompareRouteArgs {
  const FriendCompareRouteArgs({this.friendname, this.title});

  final dynamic friendname;

  final dynamic title;

  @override
  String toString() {
    return 'FriendCompareRouteArgs{friendname: $friendname, title: $title}';
  }
}

/// generated route for
/// [FriendRequestsPage]
class FriendRequestsRoute extends PageRouteInfo<FriendRequestsRouteArgs> {
  FriendRequestsRoute({
    Key? key,
    required List<String> friendRequestsList,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         FriendRequestsRoute.name,
         args: FriendRequestsRouteArgs(
           key: key,
           friendRequestsList: friendRequestsList,
           title: title,
         ),
         initialChildren: children,
       );

  static const String name = 'FriendRequestsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FriendRequestsRouteArgs>();
      return FriendRequestsPage(
        key: args.key,
        friendRequestsList: args.friendRequestsList,
        title: args.title,
      );
    },
  );
}

class FriendRequestsRouteArgs {
  const FriendRequestsRouteArgs({
    this.key,
    required this.friendRequestsList,
    required this.title,
  });

  final Key? key;

  final List<String> friendRequestsList;

  final String title;

  @override
  String toString() {
    return 'FriendRequestsRouteArgs{key: $key, friendRequestsList: $friendRequestsList, title: $title}';
  }
}

/// generated route for
/// [FriendsPage]
class FriendsRoute extends PageRouteInfo<void> {
  const FriendsRoute({List<PageRouteInfo>? children})
    : super(FriendsRoute.name, initialChildren: children);

  static const String name = 'FriendsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FriendsPage();
    },
  );
}

/// generated route for
/// [FriendsWrapperPage]
class FriendsWrapperRoute extends PageRouteInfo<FriendsWrapperRouteArgs> {
  FriendsWrapperRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         FriendsWrapperRoute.name,
         args: FriendsWrapperRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'FriendsWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FriendsWrapperRouteArgs>();
      return WrappedRoute(
        child: FriendsWrapperPage(key: args.key, title: args.title),
      );
    },
  );
}

class FriendsWrapperRouteArgs {
  const FriendsWrapperRouteArgs({this.key, required this.title});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'FriendsWrapperRouteArgs{key: $key, title: $title}';
  }
}

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
/// [RecentFavsWrapperPage]
class RecentFavsWrapperRoute extends PageRouteInfo<RecentFavsWrapperRouteArgs> {
  RecentFavsWrapperRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         RecentFavsWrapperRoute.name,
         args: RecentFavsWrapperRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'RecentFavsWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecentFavsWrapperRouteArgs>();
      return WrappedRoute(
        child: RecentFavsWrapperPage(key: args.key, title: args.title),
      );
    },
  );
}

class RecentFavsWrapperRouteArgs {
  const RecentFavsWrapperRouteArgs({this.key, required this.title});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'RecentFavsWrapperRouteArgs{key: $key, title: $title}';
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

/// generated route for
/// [WrapperPage]
class WrapperRoute extends PageRouteInfo<WrapperRouteArgs> {
  WrapperRoute({
    Key? key,
    required String title,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
         WrapperRoute.name,
         args: WrapperRouteArgs(key: key, title: title, id: id),
         initialChildren: children,
       );

  static const String name = 'WrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WrapperRouteArgs>();
      return WrappedRoute(
        child: WrapperPage(key: args.key, title: args.title, id: args.id),
      );
    },
  );
}

class WrapperRouteArgs {
  const WrapperRouteArgs({this.key, required this.title, required this.id});

  final Key? key;

  final String title;

  final String id;

  @override
  String toString() {
    return 'WrapperRouteArgs{key: $key, title: $title, id: $id}';
  }
}
