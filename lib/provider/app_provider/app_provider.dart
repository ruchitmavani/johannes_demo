import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/model/app_user_model.dart';
import 'package:johannes_demo/provider/app_provider/app_state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier(this.ref)
      : super(
          const AppState(user: null),
        );

  final Ref ref;

  void updateUser(AppUser user) {
    state = state.copyWith(user: user);
  }

  void updateName(String name) {
    if (state.user == null) {
      return;
    }
    state = state.copyWith(user: state.user?.copyWith(name: name));
  }
}

final appProvider =
    StateNotifierProvider<AppNotifier, AppState>(AppNotifier.new);
