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
  var mutualArtists = [];
  var mutualSongs = [];
  var loaded = false; 
  List<bool> showSubtext = [];
  List<bool> showSubtextMutualSongs = [];
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
        showSubtext = List<bool>.filled(friendRecentSongs.length, false);
        friendTopArtists = data["topartists"];
        loaded = true; 
      });
    }
  }


  getFriendMutuals() async {
    String friendname = widget.friendname; 
    var token = 1; 
    String? username = context.read<UsernameCubit>().state; 
    var response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_mutuals/$username/$friendname/$token"));
    print(response.body);

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      setState(() {
        mutualArtists = data["mutualartists"];
        mutualSongs = data["mutualsongs"];
        showSubtextMutualSongs = List<bool>.filled(mutualSongs.length, false);
        loaded = true; 
      });
    }
  }

  void initState(){
    super.initState();
    String? username_check = context.read<UsernameCubit>().state;
    if (username_check != null){
      username = username_check; 
    }
    getFriendRecents();
    getFriendMutuals();
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
                          !(showSubtext[index]) ? Text((index + 1).toString() + ". " + friendRecentSongs[index][0], style: titleStyleWhite) : SizedBox.shrink(),
                          (showSubtext[index]) ? Text(friendRecentSongs[index][1] + "\n" + friendRecentSongs[index][2], style: defaultStyleWhite) : SizedBox.shrink(),
                          IconButton(onPressed: () {
                              setState(() {
                                showSubtext[index] = !(showSubtext[index]);
                                //icon = showSubtext[index] ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
                              });
                          }, icon: showSubtext[index] ? Icon(Icons.arrow_upward_rounded) : Icon(Icons.arrow_downward_rounded), color: Colors.white),
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
              mutualArtists.isNotEmpty || mutualSongs.isNotEmpty ?
              Text(username + ' & ' + widget.friendname + "'s mutuals", style: titleStyleWhite) : 
              Text("You don't have any songs or artists in common with " + widget.friendname, style: titleStyleWhite),
            ),
            mutualArtists.isNotEmpty ?
            Padding(
              padding: EdgeInsets.only(left: textPaddingTitle, right: textPaddingTitle, bottom: textPaddingTitle),
              child: Text("You both listen to:", style: defaultStyleWhite)
            ) : SizedBox.shrink(),
            mutualArtists.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FriendsPagesCard(text: mutualArtists[index]);
              },
              itemCount: mutualArtists.length
            ) : SizedBox.shrink(),
            mutualSongs.isNotEmpty ?
            Padding(
              padding: EdgeInsets.only(top: textPaddingTitle, left: textPaddingTitle, right: textPaddingTitle, bottom: textPaddingTitle),
              child: Text("Custom list of songs, based on your mutual listening history:", style: defaultStyleWhite)
            ) : SizedBox.shrink(),
            mutualSongs.isNotEmpty ?
            Padding(
              padding: EdgeInsets.only(bottom: textPaddingTitle),
              child: ListView.builder(
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
                          !(showSubtextMutualSongs[index]) ? Expanded( // Wrap text in Expanded
                              child: Text(
                                (index + 1).toString() + ". " + mutualSongs[index][0], 
                                style: titleStyleWhite,
                                overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                              ),
                            ) : SizedBox.shrink(),
                          (showSubtextMutualSongs[index]) ? Expanded( // Wrap text in Expanded
                              child: Text(
                                mutualSongs[index][1] + "\n" + mutualSongs[index][2], 
                                style: defaultStyleWhite,
                                overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                              ),
                            ) : SizedBox.shrink(),
                          IconButton(onPressed: () {
                              setState(() {
                                showSubtextMutualSongs[index] = !(showSubtextMutualSongs[index]);
                                //icon = showSubtext[index] ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
                              });
                          }, icon: showSubtextMutualSongs[index] ? Icon(Icons.arrow_upward_rounded) : Icon(Icons.arrow_downward_rounded), color: Colors.white),
                        ],
                      ), 
                    )
                  )
                 );
              },
              itemCount: mutualSongs.length
            )) : SizedBox.shrink(),
        ],) 
      ) :  
        Center(
          child: CircularProgressIndicator(),
        )
    )
    );
  }
}