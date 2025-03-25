import 'package:flutter_bloc/flutter_bloc.dart';

sealed class FriendActions {}

final class AddFriend extends FriendActions{
  final String friendAdded; 
  AddFriend(this.friendAdded); 
}

final class ReplaceFriendList extends FriendActions{
  final List<String> newFriendList; 
  ReplaceFriendList(this.newFriendList); 
}

final class RemoveFriendFromRequests extends FriendActions{
  final String friendRemove; 
  RemoveFriendFromRequests(this.friendRemove); 
}

class FriendsRequestBloc extends Bloc<FriendActions, List<String>> {
  FriendsRequestBloc( List<String> initialList) : super(initialList) { 
    on<RemoveFriendFromRequests>((event, emit){
      //state gets you existing state of the current FriendsRequestBloc, which is a list of requested friends 
      //add the specified friend on AddFriend event 
      //instead of state.remove(event.friendRemove), use List.from(state)..remove(event.friendRemove) 
      //this is because state.remove(event.friendRemove) modifies the existing state array but the reference to the array (stored by state) doesn't change 
      //List.from(state) creates a new array with the same elements as the existing state array, and then removes the specified friend from this new array 
      emit(List.from(state)..remove(event.friendRemove)); 
    }
    ); 
    on<ReplaceFriendList>((event, emit){
      emit(List.from(event.newFriendList));
    }
    ); 
  }
}

class FriendsListBloc extends Bloc<FriendActions, List<String>> {
  FriendsListBloc(List<String> initialList) : super(initialList) {
    on<AddFriend>((event, emit){
      emit(List.from(state)..add(event.friendAdded)); 
    }
    );
    on<ReplaceFriendList>((event, emit){
      emit(List.from(event.newFriendList));
    }
    ); 
  }
}