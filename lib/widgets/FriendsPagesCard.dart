import 'package:flutter/material.dart';
import '../styles/styles.dart';

class FriendsPagesCard extends StatelessWidget {
  final String text; 
  final Icon? icon; 
  final VoidCallback? onPressed; 

  const FriendsPagesCard({super.key, required this.text, this.icon, this.onPressed});

  //var Icon toUse = icon ?? Icon(Icons.arrow_forward_ios_rounded);

  @override
  Widget build(BuildContext context) {
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
            Text(text, style: titleStyleWhite),
            icon != null && onPressed != null ?
            IconButton(onPressed: () {
              onPressed?.call();
            }, icon: icon!, color: Colors.white) : SizedBox.shrink(),
          ],
        ), 
      )
      )
    ); 
  }
}