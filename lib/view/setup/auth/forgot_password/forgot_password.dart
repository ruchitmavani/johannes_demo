import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/component/molecule/text_field/label_text_field.dart';
import 'package:johannes_demo/component/organism/custom_app_bar/custom_app_bar.dart';
import 'package:johannes_demo/constants/fontawesome_icon_constants.dart';
import 'package:johannes_demo/constants/regex.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/view/setup/auth/forgot_password/forgot_password_viewmodel.dart';

class ForgotPasswordView extends HookConsumerWidget {
  const ForgotPasswordView({
    super.key,
  });

  static const _formKey = GlobalObjectKey<FormState>('forgot');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final emailFocus = useFocusNode();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const CustomAppBar(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type in your email address!",
                    style: CustomTextStyle.heroTitle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LabelTextField(
                    key: const ValueKey('forgot-password-email'),
                    controller: emailController,
                    focusNode: emailFocus,
                    hintText: 'samplemail@gmailc.com',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(
                      FontAwesomeIconData.email,
                      size: 18,
                    ),
                    // onChanged: ref
                    //     .read(forgotPasswordViewModel.notifier)
                    //     .handleEmailChange,
                    validator: (value) {
                      // ignore: unnecessary_string_escapes
                      if (value == null || !emailRegex.hasMatch(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  RoundedButton(
                    text: 'Send email for password reset',
                    disabled: ref.watch(
                      forgotPasswordViewModel.select((value) {
                        return value.emailAddress.isEmpty ||
                            _formKey.currentState?.validate() == false ||
                            value.isLoading;
                      }),
                    ),
                    isLoading: ref.watch(
                      forgotPasswordViewModel.select((value) {
                        return value.isLoading;
                      }),
                    ),
                    onTap: ref
                        .read(forgotPasswordViewModel.notifier)
                        .sendResetEmail,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
