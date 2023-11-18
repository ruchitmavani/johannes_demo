import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/firebase_options.dart';
import 'package:johannes_demo/helper/country_code_helper.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/profile/profile_view.dart';
import 'package:johannes_demo/view/setup/choose_method/choose_method_view.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(NavigatorService.new);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    CountryCodeHelper.getIsoCode(),
  ]);

  setupLocator();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Johannes Demo',
      navigatorKey: locator.get<NavigatorService>().navigatorKey,
      // color: ColorPallet.black,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorPallet.background,
        textTheme: const TextTheme().apply(
          fontFamily: 'Poppins',
        ),
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(systemOverlayStyle: SystemUiOverlayStyle.light),
      ),
      home:FirebaseAuth.instance.currentUser != null?ProfileView(): ChooseMethodView(),
    );
  }
}
