import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class DataPage extends StatefulWidget {
  @override
  final String title; 
  const DataPage({super.key, required this.title}); 

  @override
  State<DataPage> createState() => _DataPageState(); 

}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Text("Data Page"),
    );
  }
}