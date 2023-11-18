import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/component/molecule/button/back_button.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/component/molecule/text_field/otp_text_field.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/helper/country_code_helper.dart';
import 'package:johannes_demo/view/setup/auth/phone/phone_viewmodel.dart';
import 'package:phone_form_field/phone_form_field.dart';

final _formKey = GlobalKey<FormState>();
final _phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

final _inputDecoration = InputDecoration(
  constraints: const BoxConstraints(minHeight: 54),
  hintText: 'Enter your phone number',
  hintStyle: CustomTextStyle.exSmallBold.copyWith(
    color: ColorPallet.black,
  ),
  alignLabelWithHint: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  counterText: '',
  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
  errorStyle: TextStyle(
    color: Colors.red.shade500,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  ),
  errorMaxLines: 1,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(width: 2,color: Colors.black)
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(width: 2,color: Colors.black),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(width: 2),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(width: 2, color: ColorPallet.grey),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(width: 2, color: Colors.red),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.red,
    ),
  ),
);

class PhoneView extends HookConsumerWidget {
  PhoneView({super.key});

  final phoneController = PhoneController(null);

  PhoneNumberInputValidator? _getValidator() {
    final validators = <PhoneNumberInputValidator>[
      PhoneValidator.valid(),
    ];

    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();
    final phoneFocus = useFocusNode();
    final otpFocus = useFocusNode();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ref.read(phoneViewModel.notifier).reset();
        });
        return null;
      },
      [],
    );

    final state = ref.read(phoneViewModel.select((value) => value));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoBackButton(),
              const SizedBox(height: 16),
              Text(
                state.isOtpSent ? 'Enter Otp' : 'Enter Phone for OTP',
                style: CustomTextStyle.heroTitle,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              if (state.isOtpSent)
                InkWell(
                  onTap: () {
                    otpController.clear();
                    ref.read(phoneViewModel.notifier).reset();
                  },
                  child: Row(
                    children: [
                      Text(
                        'Otp sent on ${state.phone}',
                        style: CustomTextStyle.smallBold,
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.edit,
                        size: 18,
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: ref.watch(
                  phoneViewModel.select((value) {
                    return value.isOtpSent;
                  }),
                )
                    ? Center(
                        child: OtpCodeTextField(
                          autofocus: true,
                          focusNode: otpFocus,
                          controller: otpController,
                          maxLength: 6,
                          otpBoxHeight: 45,
                          otpBoxWidth: 45,
                          otpBoxRadius: 25,
                          hasTextBorderColor: ColorPallet.black,
                          defaultBorderColor: ColorPallet.grey,
                          otpBoxColor: ColorPallet.background,
                          highlightColor: ColorPallet.black,
                          highlight: true,
                          isCupertino: Platform.isIOS,
                          otpTextStyle: CustomTextStyle.large
                              .copyWith(color: ColorPallet.black),
                          onTextChanged: (value) {
                            ref
                                .read(phoneViewModel.notifier)
                                .handleOtpChange(value);
                          },
                          onDone: (text) {
                            ref
                                .read(
                              phoneViewModel.notifier,
                            )
                                .verifyOtp();
                          },
                        ),
                      )
                    : PhoneFormField(
                        key: _phoneKey,
                        controller: phoneController,
                        focusNode: phoneFocus,
                        autofocus: true,
                        enabled: !state.isOtpSent,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        validator: _getValidator(),
                        defaultCountry: CountryCodeHelper.code,
                        countryCodeStyle: CustomTextStyle.smallBold,
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          ref
                              .read(phoneViewModel.notifier)
                              .handlePhoneChange(value.international);
                        },
                        decoration: _inputDecoration,
                      ),
              ),
              const Spacer(),
              SafeArea(
                child: ref.watch(
                  phoneViewModel.select((value) => value.isLoading),
                )
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ColorPallet.black,
                        ),
                      )
                    : ref.watch(
                        phoneViewModel.select((value) => value.isOtpSent),
                      )
                        ? RoundedButton(
                            text: "Verify ",
                            disabled: !ref.watch(
                              phoneViewModel
                                  .select((value) => value.otp.length == 6),
                            ),
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                ref
                                    .read(
                                      phoneViewModel.notifier,
                                    )
                                    .verifyOtp();
                              }
                            },
                          )
                        : RoundedButton(
                            text: "Send Otp",
                            disabled: ref.watch(
                              phoneViewModel.select((value) {
                                return (phoneController.value?.isValid() ==
                                        false) ||
                                    (phoneController.value?.isValidLength() ==
                                        false);
                              }),
                            ),
                            onTap: () async {
                              if (_formKey.currentState?.validate() == true) {
                                ref
                                    .read(phoneViewModel.notifier)
                                    .handlePhoneChange(
                                      phoneController.value!.international,
                                    );
                                await ref
                                    .read(
                                      phoneViewModel.notifier,
                                    )
                                    .sendOtp();
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  otpFocus.requestFocus,
                                );
                              }
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
