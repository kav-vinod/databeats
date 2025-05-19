import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:databeats/classes/RecentSongsCard.dart';

sealed class UserActions {}

final class FillRecentSongs extends UserActions {
  final List<RecentSongsCard> recentSongs; 
  FillRecentSongs(this.recentSongs); 
}

class UserRecentSongsBloc extends Bloc<FillRecentSongs, List<RecentSongsCard>> {
  UserRecentSongsBloc(List<RecentSongsCard> initialRecentSongs) : super(initialRecentSongs) {
   on <FillRecentSongs>((event, emit) {
    emit(event.recentSongs);
   });
  }
}