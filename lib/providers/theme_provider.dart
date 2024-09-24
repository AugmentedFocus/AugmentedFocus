import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:augmentedfocus/config/theme/app_theme_changer.dart';

final themNotifierProvider =
StateNotifierProvider<ThemeNotifier, AppThemeChanger>(
        (ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppThemeChanger> {
  //STATE = new AppTheme()
  ThemeNotifier() : super(AppThemeChanger());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}