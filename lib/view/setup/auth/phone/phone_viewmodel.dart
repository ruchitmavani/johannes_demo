import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/constants/firestore_constants.dart';
import 'package:johannes_demo/helper/modal_helper.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/profile/profile_view.dart';
import 'package:johannes_demo/view/setup/auth/phone/phone_state/phone_state.dart';
import 'package:johannes_demo/view/setup/complete_profile/complete_profile_view.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneViewModel extends StateNotifier<PhoneState> {
  PhoneViewModel(this.ref)
      : super(
          const PhoneState(
              phone: '', verificationId: '', otp: '', isoCode: IsoCode.JP),
        );
  final Ref ref;

  void reset() {
    state = state.copyWith(
      phone: '',
      otp: '',
      verificationId: '',
      isOtpSent: false,
      isLoading: false,
    );
  }

  void _onSignInFailed({String? errorCode, String? message}) {
    state = state.copyWith(isLoading: false);
    if (errorCode == 'email-already-in-use') {
      ModalHelper.showErrorDialog(
        title: 'Oops!',
        body: 'User with same mail already exist',
        primaryButton: ModalButtonProps(label: 'Dismiss'),
      );
    }
    if (message != null) {
      ModalHelper.showErrorDialog(
        title: 'Oops!',
        body: message,
        primaryButton: ModalButtonProps(label: 'Dismiss'),
      );
    }
  }

  Future<void> sendOtp() async {
    final phone = state.phone;
    state = state.copyWith(isLoading: true);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeAutoRetrievalTimeout: (String verificationId) {
          print('auth time');
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          state = state.copyWith(isLoading: false);
          return;
        },
        verificationFailed: (FirebaseAuthException error) async {
          state = state.copyWith(isLoading: false);
          await Fluttertoast.showToast(
            msg: 'Phone Verification Failed!',
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          state = state.copyWith(
              isLoading: false,
              isOtpSent: true,
              verificationId: verificationId);
          await Fluttertoast.showToast(
            msg: 'Sent an OTP to $phone, Please check!',
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      _onSignInFailed(message: e.message);
      return;
    } on PlatformException {
      _onSignInFailed();
      return;
    } on Exception catch (e) {
      print(e);
      _onSignInFailed();
      return;
    }
  }

  Future<void> verifyOtp() async {
    state = state.copyWith(isLoading: true);
    try {
      final phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: state.verificationId, smsCode: state.otp);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        _onSignInFailed(
            message: 'Something went wrong, Please try after some time');
        return;
      }
      if (userCredential.user != null) {
        await _signIn(userCredential.user!);
      } else {
        _onSignInFailed(message: 'Somethin went wrong');
      }

      state = state.copyWith(isLoading: false);
      return;
    } on FirebaseAuthException catch (e) {
      print(e);
      _onSignInFailed(message: e.message);
      return;
    } on PlatformException {
      _onSignInFailed();
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
        'phoneNo': user.phoneNumber,
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

  void handlePhoneChange(String value) {
    state = state.copyWith(phone: value, dummy: !state.dummy);
  }

  void handleOtpChange(String value) {
    state = state.copyWith(otp: value, dummy: !state.dummy);
  }
}

final phoneViewModel = StateNotifierProvider<PhoneViewModel, PhoneState>(
  PhoneViewModel.new,
);
