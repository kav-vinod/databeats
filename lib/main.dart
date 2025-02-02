import 'package:databeats/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'StartPage.dart';
import 'LoadingPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CodeVerifierCubit.dart';
import 'routes/app_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CodeVerifierCubit.dart';
import 'routes/app_router.dart';
import 'package:uni_links/uni_links.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CodeVerifierCubit.dart';
import 'routes/app_router.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initialLink = await getInitialLink(); // Capture deep link on startup

  runApp(
    BlocProvider(
      create: (context) => CodeVerifierCubit(null),
      child: MyApp(initialLink: initialLink),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String? initialLink;
  const MyApp({super.key, this.initialLink});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();
  String? _deepLink; // Store latest deep link

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Store initial deep link at startup
    if (widget.initialLink != null) {
      _deepLink = widget.initialLink;
      handleDeepLink(Uri.parse(_deepLink!));
    }

    // Listen for new deep links while app is running
    uriLinkStream.listen((Uri? link) {
      if (link != null) {
        //print("Deep Link Received Now: $link");
        setState(() {
          _deepLink = link.toString();
        });
        //handleDeepLink(link);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (_deepLink != null) {
        handleDeepLink(Uri.parse(_deepLink!));
      } else {
        print("Error 1, cannot get your data right now");
      }
    }
  }

  void handleDeepLink(Uri uri) {
    print("Handling Deep Link: $uri");
    if (uri.queryParameters.containsKey("code")) {
      final authCode = uri.queryParameters["code"];
      _appRouter.push(LoadingRoute(authCode: authCode, title: 'Databeats'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Databeats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}



