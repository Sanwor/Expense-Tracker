import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ExpenseFiller extends StatelessWidget {
  ExpenseFiller({super.key});
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEFE9FD),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          labelText: 'Title',
                          border: OutlineInputBorder()),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter title' : null,
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                        maxLines: 5,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        selectionHeightStyle: BoxHeightStyle.max,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder())),
                    SizedBox(height: 15.h),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Price', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || double.tryParse(value) == null
                              ? 'Enter valid price'
                              : null,
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: selectedImage != null
                          ? Image.file(selectedImage!, height: 150.h)
                          : Text('No image selected'),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(60.w, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final picked = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (picked != null) {
                            // setState(() {
                            //   selectedImage = File(picked.path);
                            // });
                          }
                        },
                        child: Icon(Icons.camera_alt_outlined)),
                    SizedBox(height: 50.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffEFE9FD),
                        minimumSize: Size(200.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedImage != null) {
                          // Save expense data
                        } else {
                          // Show a snackbar or toast: image required
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
