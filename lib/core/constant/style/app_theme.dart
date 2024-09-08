import 'package:movie_mate/core/core.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      titleTextStyle: AppText.text20.copyWith(fontWeight: FontWeight.bold),
      foregroundColor: AppColors.blackColor,
      surfaceTintColor: AppColors.blackColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5),
        backgroundColor: AppColors.primaryColor,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 4,
      backgroundColor: AppColors.blackLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      selectedLabelStyle: AppText.text14.copyWith(fontWeight: FontWeight.bold),
      unselectedItemColor: AppColors.greyColor,
      unselectedLabelStyle: AppText.text14
          .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.bold),
    ),
  );
}
