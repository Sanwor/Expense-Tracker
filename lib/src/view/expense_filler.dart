import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:expense_tracker/src/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseFiller extends StatefulWidget {
  const ExpenseFiller({super.key});

  @override
  State<ExpenseFiller> createState() => _ExpenseFillerState();
}

class _ExpenseFillerState extends State<ExpenseFiller> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descCon = TextEditingController();
  final TextEditingController priceCon = TextEditingController();

  File? selectedImage;

  @override
  void dispose() {
    titleCon.dispose();
    descCon.dispose();
    priceCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEFE9FD),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleCon,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          labelText: 'Title',
                          border: OutlineInputBorder()),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter title' : null,
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                        controller: descCon,
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
                      controller: priceCon,
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
                            setState(() {
                              selectedImage = File(picked.path);
                            });
                          }
                        },
                        child: Icon(Icons.camera_alt_outlined)),
                    SizedBox(height: 50.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 230, 221, 251),
                        minimumSize: Size(200.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        var isSuccess = await saveData(selectedImage);
                        if (isSuccess == true) {
                          Get.snackbar('Added', "Data added successfully");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, true);
                        }
                        // if (_formKey.currentState!.validate() &&
                        //     selectedImage != null) {
                        //   await FirebaseServices().addExpenseData(
                        //       description: descCon.text,
                        //       price: priceCon.text,
                        //       title: titleCon.text);
                        //   // Save expense data
                        // } else {
                        //   // Show a snackbar or toast: image required
                        // }
                      },
                      child: Text(
                        'Add',
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

  saveData(image) async {
    await Supabase.instance.client.storage
        .from('images')
        .upload('uploads/${titleCon.text}', image!);

    final imageUrl = Supabase.instance.client.storage
        .from('images')
        .getPublicUrl('uploads/${titleCon.text}');

    await FirebaseServices().addExpenseData(
        description: descCon.text,
        price: priceCon.text,
        title: titleCon.text,
        image: imageUrl);

    return true;
  }
}
