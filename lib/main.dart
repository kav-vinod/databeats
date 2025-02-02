import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'StartPage.dart';
import 'LoadingPage.dart';
import 'CodeVerifierCubit.dart';
import 'package:flutter/foundation.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => CodeVerifierCubit(null),
      child: MaterialApp(
        home: MyApp(),
        onGenerateRoute: (settings) {
          if (settings.name == '/callback') {
            final authCode = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => LoadingPage(title: 'Databeats', authCode: authCode),
            );
          }
          return null;
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    print("initState");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDeepLinkListener();
  }

  /// Handles deep links when the app is launched from a URL
  void _initDeepLinkListener() async {
    print("Checking initial deep link...");

    // Only attempt to use linkStream if it's not web
    if (!kIsWeb) {
      String? initialLink = await getInitialLink();
      if (initialLink != null) {
        Uri uri = Uri.parse(initialLink);
        print("Deep link received at startup: $uri");
        if (uri.path == '/callback') {
          _navigateToLoadingPage(uri);
        }
      }

      // Listen for deep links while the app is running
      linkStream.listen((String? link) {
        if (link != null) {
          Uri uri = Uri.parse(link);
          print("Deep link received while running: $uri");
          if (uri.path == '/callback') {
            _navigateToLoadingPage(uri);
          }
        }
      });
    } else {
      // Handle web deep link initialization (basic example)
      String? initialLink = Uri.base.toString();
      if (initialLink.contains('/callback')) {
        Uri uri = Uri.parse(initialLink);
        _navigateToLoadingPage(uri);
      }
    }
  }

  /// Handles deep links when the app resumes from the background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App Lifecycle State changed: $state");
    if (state == AppLifecycleState.resumed) {
      print("App resumed, checking for deep link...");
      _checkDeepLinkOnResume();
    }
  }

  /// Checks if a deep link is present when the app resumes
  void _checkDeepLinkOnResume() async {
    String? resumedLink = await getInitialLink();
    if (resumedLink != null) {
      Uri uri = Uri.parse(resumedLink);
      print("Deep link detected on resume: $uri");
      if (uri.path == '/callback') {
        print("Navigating to LoadingPage on resume");
        _navigateToLoadingPage(uri);
      }
    }
  }

  /// Navigates to the LoadingPage when a deep link is detected
  void _navigateToLoadingPage(Uri uri) {
    print("Navigating to LoadingPage with URI: $uri");
    print("Auth Code: ${uri.queryParameters['code']}");

    if (!mounted) {
      print("Widget not mounted, skipping navigation.");
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Attempting to navigate...");
      
      Navigator.of(context).pushReplacementNamed(
        '/callback',
        arguments: uri.queryParameters['code'],
      );
      
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StartPage(title: 'Databeats');
  }
}
