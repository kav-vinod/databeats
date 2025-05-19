import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'routes/app_router.dart';


@RoutePage()
class RecentFavsWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  final String title; 
  const RecentFavsWrapperPage({super.key, required this.title});

  @override
  Widget wrappedRoute(BuildContext context) {
    // Just return 'this' if you don't need to wrap with anything special
    // Push the UserHomeRoute with the title when this wrapper is first loaded
    //replace replaces the current route with a new route 
    //userhomepage automatically pushed to the stack via AutoRouter after the wrapper route b/c of initial for that set to true
    //manually pushing route here will push it to the stack again
    //replace replaces the current UserHomeRoute w/ a new one. 
    //context.router.replace(UserHomeRoute(title: title));
    return AutoRouter();
  }

  @override
  Widget build(BuildContext context) {
    //AutoRouter widget uses configuration defined in auto_route.dart to determine which routes to navigate to 
    //auto_route.dart defines which pages correspond to which routes and nested routes
    //AutoRoute widget automatically handles the navigation logic defined in auto_route.dart, so we don't have to redefine it on this page 
    return const AutoRouter(); 
  }
}