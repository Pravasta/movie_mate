import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/data/model/request/register_request_model.dart';

import '../../../data/datasources/auth_datasource/auth_local_datasource.dart';
import '../bloc/login_google/login_google_bloc.dart';
import '../bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObsecure = true;
  late TextEditingController _nameC;
  late TextEditingController _emailC;
  late TextEditingController _passwordC;

  @override
  void initState() {
    _nameC = TextEditingController();
    _emailC = TextEditingController();
    _passwordC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameC.dispose();
    _emailC.dispose();
    _passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget usernameField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username',
              style: AppText.text16.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              )),
          const SizedBox(height: 10),
          DefaultField(
            hintText: 'Input Username',
            controller: _nameC,
            inputType: TextInputType.text,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter our Name';
              }
              return null;
            },
          ),
        ],
      );
    }

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
            controller: _emailC,
            hintText: 'Input email address',
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
                controller: _passwordC,
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
          ),
        ],
      );
    }

    Widget buttonField() {
      return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) => MessageBar.messageBar(context, message),
            success: (user) {
              Navigation.pushNameAndRemove(RoutesName.intro);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => DefaultButton(
              title: 'Register',
              onTap: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  if (_emailC.text.isNotEmpty && _passwordC.text.isNotEmpty) {
                    final data = RegisterRequestModel(
                      name: _nameC.text,
                      email: _emailC.text,
                      password: _passwordC.text,
                    );

                    context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.register(data));
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
                Text('Or sign up with',
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const BackButton(color: AppColors.whiteColor),
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              usernameField(),
              const SizedBox(height: 15),
              emailField(),
              const SizedBox(height: 15),
              passwordField(),
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
