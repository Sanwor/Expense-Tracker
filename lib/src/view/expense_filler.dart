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
                          border: OutlineInputBorder()),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter description'
                              : null,
                    ),
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
                          : Center(
                              child: Text(
                              'selected image will appear here',
                              style: TextStyle(fontSize: 12.sp),
                            )),
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
                        // Validate text fields
                        if (!_formKey.currentState!.validate()) {
                          return; // Stop if any validator fails
                        }

                        // Check if image is selected
                        if (selectedImage == null) {
                          Get.snackbar('Missing Image',
                              'Please capture an image before submitting');
                          return;
                        }

                        // Shows loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevents dismiss by tapping outside
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 227, 215, 255)),
                            );
                          },
                        );

                        // Save data
                        var isSuccess = await saveData(selectedImage);

                        // Close the loading dialog
                        Navigator.of(context).pop();

                        if (isSuccess == true) {
                          Get.snackbar('Added', "Data added successfully");
                          Navigator.pop(context,
                              true); // Navigate back with success result
                        }
                      },
                      child: Text(
                        'Add data',
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
    var milliSecond = DateTime.now().millisecondsSinceEpoch.toString();
    await Supabase.instance.client.storage
        .from('images')
        .upload('uploads/$milliSecond', image!);

    final imageUrl = Supabase.instance.client.storage
        .from('images')
        .getPublicUrl('uploads/$milliSecond');

    await FirebaseServices().addExpenseData(
        description: descCon.text,
        price: priceCon.text,
        title: titleCon.text,
        image: imageUrl);

    return true;
  }
}
