import 'package:flutter/material.dart';
import 'package:johannes_demo/component/atom/scale_button/scale_button.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/fontawesome_icon_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/setup/auth/email/email_auth_view.dart';
import 'package:johannes_demo/view/setup/auth/phone/phone_view.dart';

class ChooseMethodView extends StatelessWidget {
  const ChooseMethodView({super.key});

  void navToEmailAuth() {
    locator.get<NavigatorService>().push(const EmailAuthView());
  }

  void navToPhoneAuthView() {
    locator.get<NavigatorService>().push(PhoneView());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Johannes Demo App!',
                style: CustomTextStyle.largeBlack,
              ),
              Text(
                'Choose one to continue',
                style: CustomTextStyle.heroTitle,
              ),
              const SizedBox(height: 20),
              _Card(
                iconData: FontAwesomeIconData.email,
                name: 'Continue with Email',
                onTap: navToEmailAuth,
              ),
              const SizedBox(height: 15),
              _Card(
                  iconData: FontAwesomeIconData.phone,
                  name: 'Continue with Phone',
                  onTap: navToPhoneAuthView,),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(
      {required this.iconData, required this.name, this.onTap,});

  final String name;
  final IconData iconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: ColorPallet.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2),),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                iconData,
                color: ColorPallet.black80,
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(name, style: CustomTextStyle.main),
            ),
          ],
        ),
      ),
    );
  }
}
