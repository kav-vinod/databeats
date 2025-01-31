class RecentSongsCard {
  final String name; 
  final List<String> artists;
  final String album; 

  const RecentSongsCard({
    required this.name, 
    required this.artists, 
    required this.album, 
  }); 

  factory RecentSongsCard.fromJson(Map<String, dynamic> json) {
    return RecentSongsCard(
      name: json['track']['name'], 
      //for lists, cast the json to a list of dynamic, then map the list to a list of strings
      //need to do this to enforce type safety; dart can easily infer the type of a single variable, but it's harder for lists since lists can be of different types
      artists: (json['track']['artists'] as List<dynamic>).map((artist) => artist['name'] as String).toList(), 
      album: json['track']['album']['name'], 
    ); 
  }
    
}