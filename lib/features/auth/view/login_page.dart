import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/data/datasources/auth_datasource/auth_local_datasource.dart';
import 'package:movie_mate/data/model/request/login_request_model.dart';
import 'package:movie_mate/features/auth/view/widgets/forgot_password_dialog.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login_google/login_google_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailC;
  late TextEditingController _passC;
  bool isObsecure = true;

  @override
  void initState() {
    _emailC = TextEditingController();
    _passC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailC.dispose();
    _passC.dispose();
  }

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
          DefaultField(
            hintText: 'Input email address',
            controller: _emailC,
            inputType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
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
          StatefulBuilder(
            builder: (context, setState) {
              return DefaultField(
                hintText: 'Input Password',
                controller: _passC,
                inputType: TextInputType.text,
                isObscure: isObsecure ? true : false,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                  icon: isObsecure
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.remove_red_eye_outlined),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Input our Password';
                  }
                  return null;
                },
              );
            },
          )
        ],
      );
    }

    Widget buttonField() {
      return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) => MessageBar.messageBar(context, message),
            success: (data) async {
              await AuthLocalDatasourceImpl().saveAuthData(data);
              Navigation.pushNameAndRemove(RoutesName.mainNavigation);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => DefaultButton(
              title: 'Login',
              onTap: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  if (_emailC.text.isNotEmpty && _passC.text.isNotEmpty) {
                    final data = LoginRequestModel(
                      email: _emailC.text,
                      password: _passC.text,
                    );

                    context.read<LoginBloc>().add(LoginEvent.login(data));
                  }
                }
              },
              height: 56,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
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
            BlocConsumer<LoginGoogleBloc, LoginGoogleState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) => MessageBar.messageBar(context, message),
                  success: (user) async {
                    await AuthLocalDatasourceImpl().saveAuthData(user);
                    Navigation.pushNameAndRemove(RoutesName.mainNavigation);
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => DefaultButton(
                    title: 'Google',
                    titleColor: AppColors.whiteColor,
                    iconUrl: Assets.icons.google.path,
                    backgroundColor: AppColors.blackLightColor,
                    borderColor: AppColors.blackLightColor,
                    onTap: () {
                      context
                          .read<LoginGoogleBloc>()
                          .add(const LoginGoogleEvent.loginGoogle());
                    },
                    height: 56,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
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

    Widget forgotPassword() {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const ForgotPasswordDialog(),
          );
        },
        child: SizedBox(
          width: context.deviceWidth,
          child: Text(
            'forgot password ?',
            textAlign: TextAlign.right,
            style: AppText.text12.copyWith(color: AppColors.greyLightColor),
          ),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              emailField(),
              const SizedBox(height: 15),
              passwordField(),
              const SizedBox(height: 15),
              forgotPassword(),
              const SizedBox(height: 30),
              buttonField(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}
