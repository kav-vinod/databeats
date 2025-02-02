import 'package:flutter/material.dart';
import 'styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CodeVerifierCubit.dart';
import 'package:http/http.dart' as http;
import 'UserHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatelessWidget {
  final String? authCode;
  final String title;
  const LoadingPage({super.key, required this.authCode, required this.title});

//asynch methods return a Future, which is returned immediately and represents a value that will be available at sone point in the future (replaced when asynch option is done)
  Future<bool> passAuthCode(String? authCode, String? codeVerifier) async {
    /*
    final url = Uri.parse("https://accounts.spotify.com/api/token"); 
    final clientID = "944de3314dac437ebacea5d195f9e0c1";
    final redirectURI = "databeats-auth://callback";
    final params = {
      "client_id": clientID,
      "redirect_uri": redirectURI,
      "grant_type": "authorization_code",
      "code": authCode,
      "code_verifier": codeVerifier,
    };

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final tokenUrl = url.replace(queryParameters: params);
    final response = await http.post(tokenUrl, headers: headers);
    print(response.body);
    if (response.statusCode == 200){
      return true; 
    }
    else{
      return false; 
    }
    */
 
    final response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_token/$authCode/$codeVerifier"));
    print(response.body);
    return true; 
    /*
    if (response.statusCode == 200){
      if (getProfile() == true){
        return true; 
      } 
      return false; 
    }
    else{
      return false; 
    }
    */
   
  }

  Future<bool> getProfile() async{
    final response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_profile"));
    print(response.body);
    return true; 
    /*
    if (response.statusCode == 200){
      return true; 
    }
    else{
      return false; 
    }
    */

  }

  Future<String?> getCodeVerifier() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('codeVerifier');
}


  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      //stateful wrapper takes an onInit function in constructor, which executes a function when widget is initialized, and a child widget to display 
      onInit : () async {
        //final codeVerifier = context.read<CodeVerifierCubit>().state;
        final codeVerifier = await getCodeVerifier();
        final codeVerifierString = codeVerifier.toString();
        //.then() method allows you to specify a callback function that will be executed when the future completes 
        //the value param represents the result of the Future once it completes, if it returns a value
        print("Code Verifier: $codeVerifierString");
        passAuthCode(authCode, codeVerifierString).then((value) {
          if (value == true) {
            print("Success");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserHomePage(title: 'Databeats')),
            );
          } else {
            print("Could not get data at this time");
          }
        });

        
        //context.read<CodeVerifierCubit>().clear(); 
      },
      child: Scaffold(
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
        //have to write a conditional statement like this to display diff things depending on if authCode is null or not, bc Center widget doesn't accept if statements as a child
        child: authCode != null ? CircularProgressIndicator() : Text("Cannot display data now", style:defaultStyleWhite),
      ),
      ),
    ));
  }
}

/// StatefulWrapper for stateful functionality to provide onInit calls in stateless widget; onInit calls are usually executed in Stateful Widgets, but since widget above is Stateless, have to use a wrapper class for an onInit call
// onInit calls allow for a function to get executed (in this case passing the auth code) when the widget is created
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}
class _StatefulWrapperState extends State<StatefulWrapper> {
@override
  void initState() {
    if(widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
