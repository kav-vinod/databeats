import 'package:flutter/material.dart';
import 'SimpleCubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'styles/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/FriendsPagesCard.dart';

@RoutePage()
class FriendComparePage extends StatefulWidget {
  final friendname; 
  final title; 
  FriendComparePage({this.friendname, this.title});

  @override
  _FriendComparePageState createState() => _FriendComparePageState();
}

class _FriendComparePageState extends State<FriendComparePage> {
  String username = "User"; 
  var friendRecentSongs = []; 
  var friendTopArtists = []; 
  var friendMutuals = []; 
  var loaded = false; 
  bool showSubtext = false;
  IconData icon = Icons.arrow_forward_ios_rounded;

  getFriendRecents() async {
    String friendname = widget.friendname; 
    var token = 1; 
    var response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_friends_info/$friendname/$token"));
    print(response.body);
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      setState(() {
        friendRecentSongs = data["recentsongs"];
        friendTopArtists = data["topartists"];
        loaded = true; 
      });
    }
  }


  getFriendMutuals() async {

  }

  void initState(){
    super.initState();
    String? username_check = context.read<UsernameCubit>().state;
    if (username_check != null){
      username = username_check; 
    }
    getFriendRecents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Colors.black,
        child: loaded?
        SingleChildScrollView(
          child: Column(
            children: [
              friendRecentSongs.isNotEmpty ?
            Padding(
              padding: EdgeInsets.all(textPaddingTitle),
              child: Text(widget.friendname + "'s 5 most recent songs", style: titleStyleWhite),
            ) : SizedBox.shrink(),
            friendRecentSongs.isNotEmpty ?
            ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) { 
                  return Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: friendButtonColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                     child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 12.0, right: 12.0),
                      child: Row(
                        children: [
                          !showSubtext ? Text((index + 1).toString() + ". " + friendRecentSongs[index][0], style: titleStyleWhite) : SizedBox.shrink(),
                          showSubtext ? Text(friendRecentSongs[index][1] + "\n" + friendRecentSongs[index][2], style: defaultStyleWhite) : SizedBox.shrink(),
                          IconButton(onPressed: () {
                              setState(() {
                                showSubtext = !showSubtext;
                                icon = showSubtext ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
                              });
                          }, icon: Icon(icon), color: Colors.white),
                        ],
                      ), 
                    )
                  )
                 );
                },
                itemCount: friendRecentSongs.length
            ): SizedBox.shrink(),
            friendTopArtists.isNotEmpty ?
            Padding(
              padding: EdgeInsets.all(textPaddingTitle),
              child: Text(widget.friendname + "'s top 5 artists this month", style: titleStyleWhite),
            ) : SizedBox.shrink(),
            friendTopArtists.isNotEmpty ?
            ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) { 
                  return FriendsPagesCard(text: (index + 1).toString() + ". " + friendTopArtists[index]);  
                },
                itemCount: friendTopArtists.length
              ): SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(textPaddingTitle),
              child: 
              friendMutuals.isNotEmpty ?
              Text(username + ' & ' + widget.friendname + "'s mutuals", style: titleStyleWhite) : 
              Text("You don't have any songs or artists in common with " + widget.friendname, style: titleStyleWhite),
            ),
            friendMutuals.isNotEmpty ?
            Text("You both listen to:", style: defaultStyleWhite) : SizedBox.shrink(),
            //friendMutuals.isNotEmpty ?
            Align(alignment: Alignment.center, child: Text("Custom list of songs, based on your mutual listening history:", style: defaultStyleWhite)),
        ],) 
      ) :  
        Center(
          child: CircularProgressIndicator(),
        )
    )
    );
  }
}