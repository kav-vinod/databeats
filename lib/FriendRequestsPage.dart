import 'package:flutter/material.dart';
import 'styles/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'SimpleCubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'FriendBlocs.dart';

@RoutePage()
class FriendRequestsPage extends StatefulWidget {
  final List<String> friendRequestsList;
  final String title; 
  const FriendRequestsPage({super.key, required this.friendRequestsList, required this.title});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  late final FriendsRequestBloc friendsRequestBloc; 

  @override
  void initState(){
    super.initState();
    friendsRequestBloc = BlocProvider.of<FriendsRequestBloc>(context);
    print(friendsRequestBloc.state); 
     
  }
   

  Future<void> addFriend(String username, String friendname, BuildContext context) async {
    var token = context.read<CodeVerifierCubit>().state; 
    var response = await http.post(Uri.parse("https://kavithavinod.pythonanywhere.com/add_friends/$username/$friendname/$token"));
    print(response.body); 
    if (response.statusCode == 200) {
      //friendsRequestBloc.add(RemoveFriendFromRequests(friendname));
      context.read<FriendsRequestBloc>().add(RemoveFriendFromRequests(friendname));
      context.read<FriendsListBloc>().add(AddFriend(friendname));
      print(context.read<FriendsRequestBloc>().state); 
    }
  }

  Future<void> rejectFriend(String username, String friendname, BuildContext context) async {
    var token = context.read<CodeVerifierCubit>().state; 
    var response = await http.post(Uri.parse("https://kavithavinod.pythonanywhere.com/reject_friends/$username/$friendname/$token"));
    print(response.body); 
    if (response.statusCode == 200) {
      //friendsRequestBloc.add(RemoveFriendFromRequests(friendname));
      context.read<FriendsRequestBloc>().add(RemoveFriendFromRequests(friendname));
      print(context.read<FriendsRequestBloc>().state); 
    }
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
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(16.0),
            child: Text("Friend Requests", style: titleStyleWhite),
          ),
          BlocBuilder<FriendsRequestBloc, List<String>> (
            builder: (context, state) {
              return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 12.0, right: 12.0),
                        child: Row(
                          children: [
                            Text(state[index], style: titleStyleWhite),
                            IconButton(onPressed: () {
                              var username = context.read<UsernameCubit>().state; 
                              if (username != null) {
                                //state[index] gets you the username of the current request, since friend requests stored in the state array (state of friendsRequestBloc provided by the BlocBuilder)
                                addFriend(username, state[index], context); 
                              }
                              
                            }, icon: Icon(Icons.check), color: Colors.green),
                            IconButton(onPressed: () {
                              var username = context.read<UsernameCubit>().state;
                              if (username != null) {
                                rejectFriend(username, state[index], context); 
                              }

                            }, icon: Icon(Icons.close), color: Colors.red),
                          ],
                        ),
                    )
                   )
                  );
                },
                itemCount: state.length,
              ),
            );
            }
          ),
          
        ],
      ),
      )
    ); 
  }
}