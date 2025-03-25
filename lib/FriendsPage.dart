import 'package:databeats/SimpleCubits.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'styles/styles.dart';
import 'SimpleCubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:databeats/routes/app_router.dart';
import 'FriendBlocs.dart';
import 'widgets/SearchBar.dart';
import 'styles/styles.dart';
@RoutePage()
class FriendsPage extends StatefulWidget {
  final String title = "Databeats"; 
  const FriendsPage({super.key}); 

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  var friendsList = <String>[]; 
  var friendRequestsList = <String>[]; 
  var loaded = false; 
  var usersList = <String>[]; 

  late final FriendsListBloc friendsListBloc; // Declare without initialization bc can't initialize Bloc w/ instance vars (ie friend list) w/o initState
  late final FriendsRequestBloc friendRequestsBloc; 

  Future<Map<String, dynamic>> getFriends(BuildContext context) async {
    var username = context.read<UsernameCubit>().state; 
    var response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_friends/$username"));
    var friendsInfoJson = <String, dynamic>{}; 
    print(response.body);
    if (response.statusCode == 200) {
      friendsInfoJson = json.decode(response.body); 
    }
    return friendsInfoJson; 
  }

  Future<List<String>> getUsers(BuildContext context) async {
    var token = 1; 
    var response = await http.get(Uri.parse("https://kavithavinod.pythonanywhere.com/get_all_users/$token"));
    var usersJson = <dynamic>[]; 
    if (response.statusCode == 200) {
      usersList = (json.decode(response.body) as List<dynamic>).map((user) => user.toString()).toList();
    }
    print(response.body);
    return usersList; 
  }

  @override
  void initState()  { 
    super.initState();
    friendsListBloc = BlocProvider.of<FriendsListBloc>(context);
    friendRequestsBloc = BlocProvider.of<FriendsRequestBloc>(context); 
    getFriends(context).then(
      (value) => setState(
        //initially widget will build with friendsList being empty
        //when async call to getFriends finishes, setState is called to update the value of friendsList, which triggers a rebuild of the widget
        //do this instead of making initState async and setting friendsList to value regularly, as initState cannot be an async function since it can only return void and not Future<void> (due to it being a set lifecycle method)
        () => {
          friendsList = value["currentfriends"].cast<String>(), 
          friendRequestsList = value["requestedfriends"].cast<String>(),
          //dispatch ReplaceFriendList event to friendsListBloc instance to update prev array of friends to new array of friends 
          friendsListBloc.add(ReplaceFriendList(friendsList)),
          friendRequestsBloc.add(ReplaceFriendList(friendRequestsList)),
          loaded = true,
          print(friendRequestsBloc.state)
        }
        
      )
    ); 
    getUsers(context).then(
      (value) => setState(
        () => usersList = value
      )
    ); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: loaded ? BlocBuilder<FriendsListBloc, List<String>> (
        builder: (context, state) {
          return Container(
            color: Colors.black,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(textPaddingTitle),
                  child: SearchAnchor.bar(
                    //Widget state property defines how a property (like color) should behave under certain states 
                    //If you wanted to, can change the background color of the search bar based on different states (like when it is pressed)
                    //barBackgroundColor expects a widget state property, which is why you can't set its value to a color directly 
                    barBackgroundColor: WidgetStateProperty.all(Colors.grey[900]), // Background color
                    barHintText: "Search friends by Spotify username", // Padding inside bar
                    barHintStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                    barShape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded border
                      side: BorderSide(color: Colors.purple.shade50, width: 1), // White border
                    )),
                    barLeading: const Icon(Icons.search, color: Colors.white),
                    viewBackgroundColor: Colors.grey[900],
                    viewHeaderTextStyle: TextStyle(color: Colors.grey[200]),
                    suggestionsBuilder: 
                    (BuildContext context, SearchController controller) {
                      final String input = controller.value.text; 
                    return usersList
                      .where((user) => user.contains(input))
                        .map((user) => 
                          ListTile(
                            title: Text(user, style: TextStyle(color: Colors.white)),
                            onTap: () {
                              controller.closeView(user); 
                            },
                            hoverColor: Colors.purple.shade50,
                            tileColor: Colors.grey[900],
                          )
                        )
                        .toList(); 
                    },
                  ), 
                ),
                BlocBuilder<FriendsRequestBloc, List<String>> (
                  builder: (context, state) {
                    return (state.isNotEmpty) ?
                    GestureDetector(
                      onTap: () {
                        context.router.push(FriendRequestsRoute(friendRequestsList: context.read<FriendsListBloc>().state, title: widget.title));
                      },
                      child: Container(
                        child: Padding(padding: EdgeInsets.all(textPaddingTitle),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Friend Requests", style: titleStyleWhite), 
                                Icon(Icons.arrow_forward_ios_rounded, color: Colors.red)
                              ],
                            )
                        )
                      )
                    )
                    : SizedBox.shrink(); 
                  }
                ),
                Padding(padding: EdgeInsets.all(textPaddingTitle),
                  child: (state.isNotEmpty) ?
                  Text("Your Friends", style: titleStyleWhite):
                  Text("Add some friends!", style: titleStyleWhite)
                ),
                (state.isNotEmpty) ?
                Expanded(
                  child: ListView.builder(
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
                                Text(state[index], style: titleStyleWhite),
                                IconButton(onPressed: () {
                                  context.router.push(FriendCompareRoute(friendname: state[index], title: widget.title));
                                }, icon: Icon(Icons.arrow_forward_ios_rounded), color: Colors.white),
                              ],
                            ), 
                        )
                      )
                      );
                    },
                    itemCount: state.length,
                  ),
                )
                : SizedBox.shrink(), //SizedBox.shrink() is basically a widget that takes no space on the screen - usually used when you want to return no widget if a condition isn't met
               ],
           )
          ); 
        }
      ):
      Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        )
      )
    );
  }
}