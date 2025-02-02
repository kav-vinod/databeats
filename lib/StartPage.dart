import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // For sha256
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'styles/styles.dart';
import 'CodeVerifierCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartPage extends StatelessWidget {
  @override

  final String title;

  StartPage({required this.title});

  Widget build(BuildContext context) {
    String generateRandomString(int length) {
      const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      final random = Random.secure();
      final values = List<int>.generate(length, (i) => random.nextInt(possible.length));
      return values.map((x) => possible[x]).join('');
    }

    Future<List<int>> hashString(String plain) async {
      // Convert the plain string to bytes
      final bytes = utf8.encode(plain);
      
      // Hash the bytes using SHA-256
      final digest = sha256.convert(bytes);
      
      // Return the hash as a list of bytes (you can convert it to a string if needed)
      return digest.bytes;
    }

    String base64Encode(List<int> input) {
          // Convert List<int> to Uint8List for base64 encoding
      Uint8List uint8List = Uint8List.fromList(input);

      // Perform base64 encoding using the dart:convert package
      String encoded = base64.encode(uint8List);

      // Custom URL-safe encoding (replace characters as per the JavaScript function)
      encoded = encoded.replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
      
      return encoded;
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
        // Listen for deep links

    Future<void> saveCodeVerifier(String codeVerifier) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('codeVerifier', codeVerifier);
    }

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      
      body: Container(
        color: Colors.black,
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to Databeats! Let's get started.",
              style: defaultStyleWhite,
            ),
            Padding(padding: EdgeInsets.all(7.5),
              child: ElevatedButton(
                onPressed:() async {
                  final codeVerifier = generateRandomString(64);
                  context.read<CodeVerifierCubit>().update(codeVerifier);
                  await saveCodeVerifier(codeVerifier);
                  final hashed = await hashString(codeVerifier); 
                  final codeChallenge = base64Encode(hashed);
                  print("Code Challenge: $codeChallenge");
                  print("Code Verifier: $codeVerifier");
                  await authenticate(codeChallenge);

                },
                child: Text('Sign in to Spotify'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  textStyle: defaultStyleBlack,
                ),
              )
            ),
          ],
        ),
      ),
    ),
    
    );
  }
}

Future<void> authenticate(String codeChallenge) async {
  final url = Uri.parse("https://accounts.spotify.com/authorize"); 
  final clientID = "944de3314dac437ebacea5d195f9e0c1";
  final redirectURI = "http://localhost:54482/callback";
  final scope = "user-read-private%20user-read-email%20user-top-read%20user-read-recently-played";

  final Map<String, String> params = {
    "client_id": clientID,
    "response_type": "code",
    "redirect_uri": redirectURI,
    "scope": scope,
    "code_challenge_method": 'S256',
    "code_challenge": codeChallenge,
  };

  final authUrl = url.replace(queryParameters: params);
  
  // Launch the URL in the browser
  if (await canLaunchUrl(authUrl)) {
    await launchUrl(authUrl, mode: LaunchMode.inAppWebView);
  } else {
    throw 'Could not launch $authUrl';
  }
}