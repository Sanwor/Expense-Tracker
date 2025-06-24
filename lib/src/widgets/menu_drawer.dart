import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildheader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildheader(BuildContext context) => Container();
  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.only(left: 24, top: 100),
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('settings'),
              onTap: () {},
            ),
            ListTile(
              title: Text('calendar'),
              onTap: () {},
            ),
            ListTile(
              title: Text(''),
              onTap: () {},
            ),
            ListTile(
              title: Text(''),
              onTap: () {},
            ),
          ],
        ),
      );
}
