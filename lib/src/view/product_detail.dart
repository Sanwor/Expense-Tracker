import 'package:expense_tracker/src/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  final dynamic doc;
  const ProductDetail({super.key, this.doc});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final containerData = FirebaseServices().getExpenseList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEFE9FD),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
        title: Text(widget.doc["title"]),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 400.h,
                  child: Image.network(
                    widget.doc["image_url"],
                    height: 400.h,
                    width: 300.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child:
                            CircularProgressIndicator(color: Color(0xffEFE9FD)),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Description:",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Text(widget.doc['description'],
                  style: TextStyle(fontSize: 15.sp)),
              SizedBox(height: 20.h),

              //date time
              Text(
                "Purchase date:",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('yyyy-MM-dd – kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(widget.doc["date_time"])),
                ),
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(height: 20.h),

              //price
              Text(
                "Price:",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Text("Rs.${widget.doc['price']}",
                  style: TextStyle(fontSize: 18.sp)),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
