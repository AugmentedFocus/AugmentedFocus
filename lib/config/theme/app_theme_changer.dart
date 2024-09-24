class AppThemeChanger {
  final bool isDarkMode;

  AppThemeChanger({this.isDarkMode = false});

  AppThemeChanger copyWith({bool? isDarkMode}) => AppThemeChanger(
      isDarkMode: isDarkMode ?? this.isDarkMode);
}