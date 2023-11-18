import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/constants/firestore_constants.dart';
import 'package:johannes_demo/helper/modal_helper.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/profile/profile_view.dart';
import 'package:johannes_demo/view/setup/auth/email/email_state/email_state.dart';
import 'package:johannes_demo/view/setup/complete_profile/complete_profile_view.dart';

final emailViewModel =
    StateNotifierProvider.autoDispose<SetupSignInViewModel, EmailState>(
  SetupSignInViewModel.new,
);

class SetupSignInViewModel extends StateNotifier<EmailState> {
  SetupSignInViewModel(this.ref)
      : super(
          const EmailState(emailAddress: '', password: ''),
        );
  final Ref ref;

  Future<bool> isEmailExists(String email) async {
    final fireStore = FirebaseFirestore.instance;

    final getUser = await fireStore
        .collection(FireStoreCollections.user)
        .where('email', isEqualTo: email)
        .get();

    return getUser.docs.isNotEmpty;
  }

  Future<void> signIn() async {
    final fireAuth = FirebaseAuth.instance;
    final email = state.emailAddress;
    final password = state.password;
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(isLoading: false);

      late UserCredential userCred;
      if (await isEmailExists(email)) {
        userCred = await fireAuth.signInWithEmailAndPassword(
            email: email, password: password,);
      } else {
        userCred = await fireAuth.createUserWithEmailAndPassword(
            email: email, password: password,);
      }

      await userCred.user?.sendEmailVerification();
      await _signIn(userCred.user!);

      //todo
      // await locator<NavigatorService>().removeAllAndPush();
    } on FirebaseAuthException catch (e) {
      print(e);
      _onSignInFailed(message: e.message);
      return;
    } on Exception catch (e) {
      print(e);
      _onSignInFailed();
      return;
    }
  }

  Future<void> _signIn(
    User user,
  ) async {
    final fireStore = FirebaseFirestore.instance;

    final getUser = await fireStore
        .collection(FireStoreCollections.user)
        .doc(user.uid)
        .get();

    if (getUser.exists) {
      state = state.copyWith(isLoading: false);
      await locator
          .get<NavigatorService>()
          .removeAllAndPush(const ProfileView());
    } else {
      final userData = <String, dynamic>{
        'id': user.uid,
        'email': user.email,
        'createdAt': Timestamp.now(),
      };
      await fireStore
          .collection(FireStoreCollections.user)
          .doc(user.uid)
          .set(userData);
      state = state.copyWith(isLoading: false);
      await locator
          .get<NavigatorService>()
          .removeAllAndPush(const CompleteProfileView());
    }
  }

  void setIsChecked({required bool isChecked}) {
    state = state.copyWith(isChecked: isChecked);
  }

  void handleEmailChange(String? value) {
    if (value != null) {
      state = state.copyWith(emailAddress: value);
    }
  }

  void handlePassChange(String? value) {
    if (value != null) {
      state = state.copyWith(password: value);
    }
  }

  void _onSignInFailed({String? message}) {
    state = state.copyWith(isLoading: false);

    if (message != null) {
      ModalHelper.showErrorDialog(
        title: 'Oops!',
        body: message,
        primaryButton: ModalButtonProps(label: 'Dismiss'),
      );
    }
  }
}
