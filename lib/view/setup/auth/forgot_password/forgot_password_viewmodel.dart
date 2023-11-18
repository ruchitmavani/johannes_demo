import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/helper/debouncer.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/setup/auth/forgot_password/forgot_password_state/forgot_password_state.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel(this.ref)
      : super(
          const ForgotPasswordState(emailAddress: ''),
        );
  final Ref ref;
  final _debouncer = Debouncer(milliseconds: 100);

  Future<void> sendResetEmail() async {
    final email = state.emailAddress;
    state = state.copyWith(isLoading: true);
    //todo forgot
    state = state.copyWith(isLoading: false);
    await Fluttertoast.showToast(
      msg: 'Email Sent for reset password on ${state.emailAddress}',
    );
    await locator<NavigatorService>().goBack();
  }

  void handleEmailChange(String? value) {
    _debouncer.run(() {
      state = state.copyWith(emailAddress: value ?? '');
    });
  }
}

final forgotPasswordViewModel =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>(
  ForgotPasswordViewModel.new,
);
