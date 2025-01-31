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


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get initial deep link
  final initialLink = await getInitialLink();
  if (initialLink != null) {
    print("Deep Link on Start: $initialLink");
  }

  // Listen for deep links when the app is already running
  uriLinkStream.listen((Uri? link) {
    if (link != null) {
      print("Deep Link Received: $link");
    }
  });
  runApp(BlocProvider(
    create: (context) => CodeVerifierCubit(null), 
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Print deep link on app start
  Future.delayed(Duration.zero, () {
    print("Deep Link Received: ${Uri.base}");
  });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has resumed, check for deep link
      final uri = Uri.base;
      print("Full URI: $uri");
      print("Path: ${uri.path}");
      print("Query Parameters: ${uri.queryParameters}");
      handleDeepLink(uri, context);
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

  void handleDeepLink(Uri uri, BuildContext context) {
    if (uri.path == "/callback" && uri.queryParameters.containsKey("code")) {
      final authCode = uri.queryParameters["code"];
      _appRouter.push(LoadingRoute(authCode: authCode, title: 'Databeats'));
    }
  }
}

/*
void main() {
  runApp(BlocProvider(
    create: (context) => CodeVerifierCubit(null), 
    child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Databeats',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      //home: StartPage(title: 'Databeats'),
      
      /*
      onGenerateRoute: (RouteSettings settings) {
        // Handle incoming routes here
        if (settings.name != null) {
          final uri = Uri.parse(settings.name!);
    
    // Check if this is a callback from Spotify
    if (uri.queryParameters.containsKey('code')) {
      //line of code below returns a String? instead of String, bc it could be true that the code parameter isn't found
      //loading page must also accept a String?, if not convert String? to String here
      final authCode = uri.queryParameters['code'];
      print(authCode);
      return MaterialPageRoute(
              builder: (context) => LoadingPage(authCode: authCode, title: 'Databeats'),
              // Set this to true to remove all previous routes from the stack
              fullscreenDialog: true,
            );
          }
        }
        return null; // Return null to use default behavior
      },
      */
    );
  }
}
*/


