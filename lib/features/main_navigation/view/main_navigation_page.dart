import 'package:movie_mate/features/main_navigation/cubit/main_navigation_cubit.dart';

import '../../../core/core.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainNavigationCubit>(
      create: (context) => MainNavigationCubit(),
      child: content(),
    );
  }

  Widget content() {
    return BlocBuilder<MainNavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: MainNavigationModel.listPage.elementAt(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              context.read<MainNavigationCubit>().changeTab(value);
            },
            items: MainNavigationModel.listBottomNavbar
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: Image.asset(
                      e['icon'],
                      width: 28,
                      color: currentIndex == e['index']
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                    label: e['label'],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
