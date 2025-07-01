import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEFE9FD),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.sp)),
              child: Container(
                color: Color(0xffEFE9FD),
                height: 200.h,
                width: double.infinity.w,
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(radius: 60.sp, backgroundImage: null),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Upload image through:'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.sp),
                                            ),
                                          ),
                                          child: Text('Gallery')),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final picked = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          if (picked != null) {
                                            setState(() {});
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.sp),
                                          ),
                                        ),
                                        child: Text('Camera'),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_outlined),
                              Text('change picture'),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'User',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
