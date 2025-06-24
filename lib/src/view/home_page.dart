import 'package:expense_tracker/src/view/expense_filler.dart';
import 'package:expense_tracker/src/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDrawer drawerTab = Get.put(MyDrawer());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffEFE9FD),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              onPressed: () {},
              label: Icon(Icons.person),
            )
          ],
        ),
        drawer: drawerTab,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xffEFE9FD),
            onPressed: () => Get.to(() => ExpenseFiller()),
            label: Row(
              children: [Icon(Icons.add), Text('Add')],
            )),
        body: Column(
          children: [
            ColoredBox(
              color: Color(0xffEFE9FD),
              child: SizedBox(
                height: 110.h,
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: 10.sp),
                  child: Text(
                    'Track\nyour Expenses.',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      "Today's records",
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //data container
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return null;
                    }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
