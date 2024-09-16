import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/data/datasources/auth_datasource/auth_local_datasource.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 3),
        () => AuthLocalDatasourceImpl().isLogin(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return const MainNavigationPage();
          } else {
            return const IntroductionPage();
          }
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MOVIEMate',
                      style: AppText.text28
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'you can booking movies with our favorite friend',
                      style: AppText.text14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
