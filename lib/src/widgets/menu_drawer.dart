import 'package:expense_tracker/src/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        padding: EdgeInsets.only(left: 24.sp, top: 100.sp),
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              title: Text('Profile'),
              onTap: () => Get.to(ProfilePage()),
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
