import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/component/molecule/text_field/border_text_field.dart';
import 'package:johannes_demo/component/organism/error_modal/error_modal.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/enums.dart';
import 'package:johannes_demo/constants/firestore_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/helper/modal_helper.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/profile/profile_view.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({
    super.key,
  });

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? birthDate;
  Gender? gender;
  XFile? _image;
  final storage = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  String imageUrl = '';
  bool isImageUploading = false;
  bool isUserStoreInProgress = false;

  Future<XFile?> cropImage(XFile selectImage) async {
    if (selectImage.path.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: selectImage.path,
        compressQuality: 80,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );
      if (croppedFile != null) {
        setState(() {
          isImageUploading = true;
        });
        return XFile(croppedFile.path);
      } else {
        setState(() {
          isImageUploading = false;
        });
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = await cropImage(image);
      Navigator.pop(context);
      if (_image != null) {
        await uploadImageToFirebase(File(_image!.path)).then((value) {
          imageUrl = value;
          setState(() {
            isImageUploading = false;
          });
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _image = await cropImage(image);
      setState(() {});
      Navigator.pop(context);

      if (_image != null) {
        await uploadImageToFirebase(File(_image!.path)).then((value) {
          imageUrl = value;
          setState(() {
            isImageUploading = false;
          });
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final reference = FirebaseStorage.instance
        .ref()
        .child('profile/${fireAuth.currentUser?.uid}/$timestamp');

    final uploadTask = reference.putFile(imageFile);

    final taskSnapshot = await uploadTask.whenComplete(() {});
    final getImageUrl = await taskSnapshot.ref.getDownloadURL();

    return getImageUrl;
  }

  Future<void> storeUserDetails({
    required String name,
    required String gender,
    required int birthDate,
    required String imgUrl,
  }) async {
    try {
      setState(() {
        isUserStoreInProgress = true;
      });
      final firestore = FirebaseFirestore.instance;
      final user = fireAuth.currentUser;
      final userUid = user?.uid;
      final documentReference =
          firestore.collection(FireStoreCollections.user).doc(userUid);

      await documentReference.update({
        'name': name,
        'gender': gender,
        'dob': birthDate,
        'imageUrl': imgUrl,
      });
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Widget _buildProfileImage() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.file(
          File(_image!.path),
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const ColoredBox(
          color: ColorPallet.bgSub,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.person,
              size: 100,
              color: ColorPallet.background,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate) {
      _dateController.text = DateFormat('dd-MMM-yyyy').format(picked);
      birthDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.4 - AppBar().preferredSize.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Center(
                            child: Text(
                              'Complete profile',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: showModalSheet,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  _buildProfileImage(),
                                  Positioned(
                                    bottom: -1,
                                    right: -3,
                                    child: GestureDetector(
                                      onTap: showModalSheet,
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorPallet.black,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Full Name', style: CustomTextStyle.main),
                    const SizedBox(height: 5),
                    BorderTextField(
                      controller: _nameController,
                      hintText: 'Enter your full name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is Require';
                        }
                        return null;
                      },
                    ),
                    Text('Gender', style: CustomTextStyle.main),
                    Row(
                      children: List.generate(
                          Gender.values.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = Gender.values[index];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Radio<Gender>(
                                      value: Gender.values[index],
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                        });
                                },
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  return ColorPallet.black;
                                }),
                              ),
                              Text(
                                Gender.values[index].name,
                                style: CustomTextStyle.smallExtraBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text('Birth Date', style: CustomTextStyle.main),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: _selectDate,
                      child: AbsorbPointer(
                        child: BorderTextField(
                          controller: _dateController,
                          hintText: 'Select BirthDate',
                          suffixIcon: const Icon(Icons.calendar_month),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select Birthdate';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: size.height * 0.1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: isImageUploading == true ||
                                isUserStoreInProgress == true
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isImageUploading)
                                      Text(
                                        'Uploading Image',
                                        style: CustomTextStyle.exSmallBold
                                            .copyWith(color: ColorPallet.black),
                                      ),
                                    const SizedBox(width: 10),
                                    const CircularProgressIndicator(
                                      color: ColorPallet.black,
                                    ),
                                  ],
                                ),
                              )
                            : RoundedButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final name = _nameController.text.trim();
                                    if (_image == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please pick an image.'),
                                        ),
                                      );
                                      return;
                                    }
                                    if (gender == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please select gender.'),
                                        ),
                                      );
                                      return;
                                    }

                                    await storeUserDetails(
                                      name: name,
                                      birthDate:
                                          birthDate!.millisecondsSinceEpoch,
                                      gender: gender!.name,
                                      imgUrl: imageUrl,
                                    ).then((_) {
                                      locator
                                          .get<NavigatorService>()
                                          .removeAllAndPush(
                                            const ProfileView(),
                                          );
                                    }).then((value) {
                                      setState(() {
                                        isUserStoreInProgress = false;
                                      });
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Error updating user details.',
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        isUserStoreInProgress = false;
                                      });
                                    });
                                  }
                                },
                                text: 'Submit',
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (fireAuth.currentUser != null &&
              fireAuth.currentUser?.email != null &&
              !(fireAuth.currentUser?.emailVerified ?? true))
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow()],
                    ),
                    child: ErrorModal(
                      title: 'Email is Not Verified',
                      description: 'please check inbox for verification mail',
                      primaryButton: ModalButtonProps(
                        label: 'Already Verified',
                        extraAction: () async {
                          await fireAuth.currentUser?.reload();
                          setState(() {});
                        },
                      ),
                      pop: () {},
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> showModalSheet() async {
    await showModalBottomSheet<void>(
      backgroundColor: ColorPallet.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (_) {
        return SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.photo_on_rectangle,
                        size: 35,
                        color: ColorPallet.black,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Choose From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: _pickImageFromCamera,
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.camera_on_rectangle,
                        size: 35,
                        color: ColorPallet.black,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Click Now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
