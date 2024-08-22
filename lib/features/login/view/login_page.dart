import 'package:movie_mate/core/import.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const BackButton(color: AppColors.whiteColor),
        title: const Text('Sign In'),
      ),
    );
  }
}
