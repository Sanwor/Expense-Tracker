import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecordContainer extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;
  final String dateTimeMilisecond;
  final String itemImage;
  final double itemPrice;
  final VoidCallback onTap;

  const RecordContainer({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.itemImage,
    required this.itemPrice,
    required this.dateTimeMilisecond,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffEFE9FD),
              borderRadius: BorderRadius.circular(20.sp)),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                //title
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 'delete') {
                          try {
                            await Supabase.instance.client.storage
                                .from('images')
                                .remove(['uploads/$dateTimeMilisecond']);

                            await FirebaseFirestore.instance
                                .collection('expenseList')
                                .doc(dateTimeMilisecond
                                    .toString()) //used dateTime instead of id
                                .delete();

                            Get.snackbar(
                                'Deleted', 'Expense successfully deleted');
                          } catch (e) {
                            Get.snackbar('Error', 'Failed to delete: $e');
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    //image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: Image.network(
                              itemImage,
                              height: 100.h,
                              width: 100.w,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.grey),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10.w),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //description
                          Text(description),
                        ]),
                  ],
                ),

                //price
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            dateTime,
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.grey),
                          )
                        ],
                      ),
                    ),

                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Rs.${itemPrice.toString()}",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
