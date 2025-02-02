import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'styles/styles.dart';
import 'dart:convert';
import 'classes/RecentSongsCard.dart';

class UserHomePage extends StatefulWidget {
  @override

  final String title;

  const UserHomePage({required this.title});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  var recentlyPlayedList = <RecentSongsCard>[]; 

  Future<List<RecentSongsCard>> getRecentlyPlayed() async {
    print("Getting recently played");
    final url = Uri.parse("https://kavithavinod.pythonanywhere.com/get_recently_played");
    final response = await http.get(url);

    var recentlyPlayedList = <RecentSongsCard>[]; 

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      //done bc array of tracks accessed by 'items' keyword in dictionary 
      print(jsonResponse);
      var recentlyPlayed = jsonResponse['items']; 
      for (var item in recentlyPlayed) {
        recentlyPlayedList.add(RecentSongsCard.fromJson(item));
      }
    } else {
      throw Exception("Failed to load recently played");
    }
    return recentlyPlayedList;
  }
  
  @override
  void initState() {
    //when widget is inserted into the widget tree, call getRecentlyPlayed
    //overall process:
    //1. widget created, its constructor is called. B/c this is a StatefulWidget, createState is called to create the State object, which holds the mutable state of the widget
    //State object lives in memory as part of the widget's lifecycle; maintained across rebuilds 
    //2. State object created -> initState method called. setState is called to set state of widget here within initState, as we want the list of recently played songs to be set before the widget is inserted into the widget tree
    //3. InitState done -> build method called. Widget tree constructed based on current state of widget (widget inserted into tree)
    //4. if any updates need to be made, call setState again (outside of initState), and initState is called only upon creation of a widget
    getRecentlyPlayed().then((value) => 
      //call setState, which takes in a function that sets recentlyPlayedList to the value returned by getRecentlyPlayed
      //calling setState notifies framework that the state of the object has changed in order to trigger a rebuild
      setState(() => 
        recentlyPlayedList = value));
    super.initState(); 
  }
  
  
  @override
  Widget build(BuildContext context) {
    //widget tree created in the build method is what is rendered on the screen 
    //build method called to rebuild widget tree when state changes 
    //however, initState won't be called after the first build, because widget building is different from widget creation (calling of constructor, hetting associated state object) only happens once
    //if a widget was reinitialized on every state change, any vars or configs set in initState or info re the previous state (ex. updating previous val of a counter to a new val) would be lost + would hinder performance 
    //TLDR: State object lives in memory as part of the widget's lifecycle; maintained across rebuilds. Widget tree represents UI structure, and is rebuilt when state changes. 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container (
        color: Colors.black,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16.0),
              child: Text("Your Recently Played Songs", style: titleStyleWhite),
            ),
            Expanded (
              //ListView is a scrolling widget
              //ListView.builder is a builder widget that builds a list of widgets dynamically - good for when you have a large list of items to display and want to render them dynamically as user scrolls down
              child: ListView.builder(
                //item builder is an instance of a function NullableIndexedWidgetBuilder, which takes in a context and an index (like index of a list), and returns a widget for that index in the list
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container (
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Card(
                      color: Colors.black,
                      child: Padding (
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 18.0, right: 18.0),
                          child: Column(
                            children: <Widget>[
                              Text(recentlyPlayedList[index].name, textAlign: TextAlign.center, style: defaultStyleWhite),
                              Text("Artist(s): ${recentlyPlayedList[index].artists.join(", ")}", textAlign: TextAlign.center, style: subSectionStyleWhite),
                              Text("Album: ${recentlyPlayedList[index].album}", textAlign: TextAlign.center, style: subSectionStyleWhite),
                            ],
                          ),
                        )
                      )
                    ) 
                  );
                  },
                  //itemCount is the number of items in the list, and is the # of times itemBuilder is called
                  //if not specified, index will increment and if list whose vals index is used to access inside is <= than index, you'll get an out of bounds error
                  itemCount: recentlyPlayedList.length,
              )
            )
          ]
        )
      )
    );
  }

}

