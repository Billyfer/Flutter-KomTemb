import 'package:flutter/material.dart';

class DashboardMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {

      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'home',
          child: Text('Home'),
        ),
        const PopupMenuItem<String>(
          value: 'newComic',
          child: Text('New Comic'),
        ),
      ],
    );
  }
}
