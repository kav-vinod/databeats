import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:databeats/classes/RecentSongsCard.dart';
import 'package:databeats/UserBlocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:databeats/styles/styles.dart';

@RoutePage()
class DataPage extends StatefulWidget {
  @override
  final String title; 
  const DataPage({super.key, required this.title}); 

  @override
  State<DataPage> createState() => _DataPageState(); 

}

//gets values for pie chart for songs by a single artist
List<PieChartSectionData> getSingleValues (List<RecentSongsCard> recentSongs, int? hoveredIndex) {
  Map<String, double> valueMap = {};
  List<PieChartSectionData> sections = []; 
  var total = 0; 
  for (var song in recentSongs) {
    if (song.artists.length == 1) {
      var artist = song.artists[0];
      if (valueMap.containsKey(artist)) {
        valueMap[artist] = valueMap[artist]! + 1;
      } else {
      valueMap[artist] = 1;
    }
    total += 1; 
  }
  }

  final colors = [
    Colors.purple,
    Color(0xFF00BCD4) ,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  if (total == 0) {
      total = 1; 
    }

  var colorIndex = 0; 
  for (var key in valueMap.keys) {
    String add_str = key + ", " + valueMap[key]!.toString(); 
    sections.add(PieChartSectionData(value: valueMap[key]! / total, color: colors[colorIndex % colors.length], title: hoveredIndex == colorIndex ? add_str : "", titleStyle: TextStyle(color: Colors.white)));
    colorIndex += 1; 
  }
   return sections;
}

//gets values for pie chart for songs by multiple artists/collab songs 
List<PieChartSectionData> getCollabValues (List<RecentSongsCard> recentSongs, int? hoveredCollabIndex) {
  Map <String, double> valueMap = {}; 
  List<PieChartSectionData> sections = []; 
  var total = 0;  

   final colors = [
    Colors.purple,
    Color(0xFF00BCD4) ,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  for (var song in recentSongs) {
    if (song.artists.length > 1) {
      var artists = ""; 
      for (var artist in song.artists) { 
        artists += artist + ", "; 
      }
      if (valueMap.containsKey(artists)) {
        valueMap[artists] = valueMap[artists]! + 1; 
      } else {
        valueMap[artists] = 1; 
      }
    }
  }
  if (total == 0) {
      total = 1; 
    }
  
  var colorIndex = 0; 
  for (var key in valueMap.keys) {
    String add_str = key + ", " + valueMap[key]!.toString(); 
    sections.add(PieChartSectionData(value: valueMap[key]! / total, color: colors[colorIndex], title: hoveredCollabIndex == colorIndex ? add_str : "", titleStyle: TextStyle(color: Colors.white))); 
    colorIndex += 1; 
  }
  return sections; 
}



class _DataPageState extends State<DataPage> {
  int? hoveredIndex = 0; 
  int? hoveredCollabIndex = 0; 
  List<RecentSongsCard> recentSongs = [];
  //context (context of widget tree) only available inside methods like build, initState, or lifecycle methods recieving Buildcontext as a parameter
  @override
  void initState(){
    super.initState();
    recentSongs = context.read<UserRecentSongsBloc>().state;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Data Page"),
      ),
      body: Container (
        color: Colors.black, 
        //when you nest a Column inside an Expanded wudget, abd have an Expanded widget in that column, Flutter doesn't know how to allocate space for Each (Expanded widgets = take the full height of parent) causing an overflow error. avoid nesting to fix this. 
        child: Column(
      children: [
      Expanded(
          child: Column(
            children: [
              Center(child: Text("Single Artist Songs", style: titleStyleWhite)),
              Expanded(
                child: PieChart(
                  PieChartData(
                  sections: getSingleValues(recentSongs, hoveredIndex),
                  sectionsSpace: 5, 
                  //centerSpaceRadius: 50, 
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (event is FlTapUpEvent || event is FlPanEndEvent) {
                                //hoveredIndex = null;
                              } else if (event is FlPanUpdateEvent) {
                                hoveredIndex =  pieTouchResponse?.touchedSection?.touchedSectionIndex;
                              }
                            });
                          },
                        )
                )
              )
              )
            ]
          )
        ),
        getCollabValues(recentSongs, hoveredCollabIndex).length > 0 ?
        Expanded(
          child: Column(
            children: [
              Center(child: Text("Collab Songs", style: titleStyleWhite)),
              Expanded(
              
                child: PieChart(
                  PieChartData(
                    sections: getCollabValues(recentSongs, hoveredCollabIndex),
                    sectionsSpace: 5, 
                  //centerSpaceRadius: 50, 
                   pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (event is FlTapUpEvent || event is FlPanEndEvent) {
                                //hoveredCollabIndex = null;
                              } else if (event is FlPanUpdateEvent) {
                                hoveredCollabIndex =  pieTouchResponse?.touchedSection?.touchedSectionIndex;
                              }
                            });
                          },
                        )
                  
                  )
                  
                )
               
              )
            ]
          )
        ): SizedBox.shrink(),
        
      ],
        ),
      ),
    );
  }
}
