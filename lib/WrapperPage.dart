import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:databeats/routes/app_router.dart';
import 'SimpleCubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:databeats/UserBlocs.dart';

@RoutePage()
class WrapperPage extends StatelessWidget implements AutoRouteWrapper { 
  final String title; 
  final String id;
  const WrapperPage({super.key, required this.title, required this.id}); 

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsernameCubit>(
          create: (context) => UsernameCubit(id),
        ),
         BlocProvider<UserRecentSongsBloc>(
          create: (context) => UserRecentSongsBloc([]),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        RecentFavsWrapperRoute(title: title),
        DataRoute(title: title),
        FriendsWrapperRoute(title: title),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Recent Favs"),
          BottomNavigationBarItem(icon: Icon(Icons.data_exploration), label: "Data"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_people), label: "Friends"),
        ], 
        currentIndex: tabsRouter.activeIndex, 
        onTap: tabsRouter.setActiveIndex,
        ); 
      }
    ); 
  }
}