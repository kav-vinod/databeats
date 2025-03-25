import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'FriendBlocs.dart';

@RoutePage()
class FriendsWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  final String title; 
  const FriendsWrapperPage({super.key, required this.title});

  //wrapped route method allows you to wrap route with additional functionality, in this case providing a Bloc to the route 
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //creates a new instance of FriendsListBloc and provides it to the widget tree 
        BlocProvider<FriendsListBloc>(
          create: (context) => FriendsListBloc([])
        ),
        BlocProvider<FriendsRequestBloc>(
          create:(context) => FriendsRequestBloc([])
        )
      ],
      //makes the output of the build method a child of BlocProvider, so any descendents have access to the BlocProvider bc it's below the BlocProvider in the widget tree 
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    //AutoRouter widget uses configuration defined in auto_route.dart to determine which routes to navigate to 
    //auto_route.dart defines which pages correspond to which routes and nested routes
    //AutoRoute widget automatically handles the navigation logic defined in auto_route.dart, so we don't have to redefine it on this page 
    return const AutoRouter(); 
  }
}
