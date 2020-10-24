import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class GrabSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          blurRadius: 20.0,
          color: Colors.black.withOpacity(0.2),
        )],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 8.5,
            margin: EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
          ),
        ],
      ),
    );
  }
}