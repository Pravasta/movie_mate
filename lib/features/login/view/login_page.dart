import 'package:movie_mate/core/core.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget emailField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email Address',
              style: AppText.text16.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              )),
          const SizedBox(height: 10),
          const DefaultField(
            hintText: 'Input email address',
            inputType: TextInputType.emailAddress,
          ),
        ],
      );
    }

    Widget passwordField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password',
              style: AppText.text16.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              )),
          const SizedBox(height: 10),
          const DefaultField(
            hintText: 'Input Password',
            inputType: TextInputType.text,
            isObscure: true,
            suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ],
      );
    }

    Widget buttonField() {
      return DefaultButton(
        title: 'Login',
        onTap: () => Navigation.pushNameAndRemove(RoutesName.mainNavigation),
        height: 56,
      );
    }

    Widget footer() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 1 / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.greyColor)),
                const SizedBox(width: 10),
                Text('Or sign in with',
                    style:
                        AppText.text12.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                const Expanded(child: Divider(color: AppColors.greyColor)),
              ],
            ),
            DefaultButton(
              title: 'Google',
              titleColor: AppColors.whiteColor,
              iconUrl: Assets.icons.google.path,
              backgroundColor: AppColors.blackLightColor,
              borderColor: AppColors.blackLightColor,
              onTap: () {},
              height: 56,
            ),
            Text(
              'By sign in or sign up, you agree to our Terms of Service\nand Privac y Policy',
              textAlign: TextAlign.center,
              style: AppText.text10.copyWith(color: AppColors.greyLightColor),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const BackButton(color: AppColors.whiteColor),
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            emailField(),
            const SizedBox(height: 15),
            passwordField(),
            const SizedBox(height: 30),
            buttonField(),
            const Spacer(),
            footer(),
          ],
        ),
      ),
    );
  }
}
