import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/component/molecule/button/back_button.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/component/molecule/text_field/label_text_field.dart';
import 'package:johannes_demo/constants/fontawesome_icon_constants.dart';
import 'package:johannes_demo/constants/regex.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/view/setup/auth/email/email_auth_viewmodel.dart';

class EmailAuthView extends HookConsumerWidget {
  const EmailAuthView({super.key});

  static const _formKey = GlobalObjectKey<FormState>('signin');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final isEmailChanged = useState<bool>(false);
    final isPassChanged = useState<bool>(false);
    final emailFocus = useFocusNode();
    final passFocus = useFocusNode();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const GoBackButton(),
                const SizedBox(height: 16),
                Text(
                  'Enter Email',
                  style: CustomTextStyle.heroTitle,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10),
                LabelTextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  hintText: 'Enter your email',
                  label: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    FontAwesomeIconData.email,
                    size: 18,
                  ),
                  onChanged: (value) {
                    isEmailChanged.value = true;
                    ref.read(emailViewModel.notifier).handleEmailChange(value);
                  },
                  validator: (value) {
                    if (!isEmailChanged.value) {
                      return null;
                    }
                    // ignore: unnecessary_string_escapes
                    if (value == null || !emailRegex.hasMatch(value)) {
                      return 'Enter Valid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                if (ref.watch(
                  emailViewModel.select((value) {
                    return emailRegex.hasMatch(value.emailAddress);
                  }),
                ))
                  LabelTextField(
                    controller: passwordController,
                    focusNode: passFocus,
                    hintText: 'Enter your password',
                    label: 'Password',
                    isPassword: true,
                    showEye: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                      if (value.length < 8) {
                        return 'Minimum 8 characters required';
                      }
                    },
                    prefixIcon: const Icon(
                      FontAwesomeIconData.key,
                      size: 18,
                    ),
                    onChanged: (value) {
                      isPassChanged.value = true;
                      ref.read(emailViewModel.notifier).handlePassChange(value);
                    },
                  ),
                const SizedBox(height: 8),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: ScaleButton(
                //     onTap: () async {
                //       await locator<NavigatorService>()
                //           .push(RouteName.forgotPassword, arg: true);
                //     },
                //     child: Text(
                //       t.setup.password.forgot,
                //       style: CustomTextStyle.smallBold
                //           .copyWith(decoration: TextDecoration.underline),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 15),
                RoundedButton(
                  text: 'Next',
                  disabled: ref.watch(
                    emailViewModel.select((value) {
                      return _formKey.currentState?.validate() == false ||
                          value.emailAddress.isEmpty;
                    }),
                  ),
                  onTap: ref.read(emailViewModel.notifier).signIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
