import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/src/services/firebase_services.dart';
import 'package:expense_tracker/src/view/expense_filler.dart';
import 'package:expense_tracker/src/view/profile_page.dart';
import 'package:expense_tracker/src/widgets/menu_drawer.dart';
import 'package:expense_tracker/src/widgets/record_container.dart';
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
              onPressed: () => Get.to(() => ProfilePage()),
              label: Icon(
                Icons.person,
                color: Colors.black,
              ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                child: ColoredBox(
                  color: Color(0xffEFE9FD),
                  child: SizedBox(
                    height: 110.h,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.sp, bottom: 10.sp, left: 20.sp),
                      child: Text(
                        'Track\nyour Expenses.',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10),
                    child: Text(
                      "Today's records",
                      textAlign: TextAlign.left,
                    ),
                  ),

                  //data container
                  StreamBuilder(
                    stream: FirebaseServices().getExprenseList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      var data = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data == null) {
                        return SizedBox(
                          child: Text("No Data Found"),
                        );
                      }

                      return SizedBox(
                        height: 550.h,
                        child: ListView(
                          children: snapshot.data!.docs.map((document) {
                            return RecordContainer(
                              description: document['description'],
                              itemImage: "image",
                              itemPrice:
                                  double.parse(document['price'].toString()),
                              title: document['title'],
                              dateTime: DateTime.now().toString(),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
