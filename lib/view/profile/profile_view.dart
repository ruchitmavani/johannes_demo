import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/firestore_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/model/app_user_model.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/setup/choose_method/choose_method_view.dart';
import 'package:johannes_demo/view/setup/complete_profile/complete_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLoaded = false;
  AppUser? user;
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;

  Future<void> getUserData() async {
    try {
      if (fireAuth.currentUser?.uid == null) {
        await locator
            .get<NavigatorService>()
            .removeAllAndPush(const ChooseMethodView());
      }
      final userData = await fireStore
          .collection(FireStoreCollections.user)
          .doc(fireAuth.currentUser?.uid)
          .get();

      final data = AppUser.fromJson(userData.data()!);

      setState(() {
        user = data;
      });
    } catch (e) {
      if (fireAuth.currentUser?.uid != null) {
        await locator
            .get<NavigatorService>()
            .removeAllAndPush(const CompleteProfileView());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something Went Wrong")));
      }
    }
  }

  Widget _buildProfileImage() {
    if (user?.imageUrl != null && (user?.imageUrl.isNotEmpty ?? false)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          user!.imageUrl,
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
            padding: EdgeInsets.all(8.0),
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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        'Profile',
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
                      child: _buildProfileImage(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Name: ${user?.name}', style: CustomTextStyle.main),
              Text('Gender: ${user?.gender.name}',
                  style: CustomTextStyle.main),
              if (user?.dob != null)
                Text(
                    "Birth Date: ${DateFormat('dd-MMM-yyyy').format(user!.dob)}",
                    style: CustomTextStyle.main),
              if (user?.phoneNo != null)
                Text('Phone No: ${user?.phoneNo}',
                    style: CustomTextStyle.main),
              if (user?.email != null)
                Text('Email: ${user?.email}', style: CustomTextStyle.main),
              //todo put log out if time remains
              if (kDebugMode)
                SizedBox(height: 30),
              if (kDebugMode)
                RoundedButton(
                  text: 'Log Out',
                  onTap: () {
                    fireAuth.signOut().then((value) => locator
                        .get<NavigatorService>()
                        .removeAllAndPush(const ChooseMethodView()));
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
