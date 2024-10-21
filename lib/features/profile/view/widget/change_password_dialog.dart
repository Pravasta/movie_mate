import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/profile/bloc/change_password/change_password_bloc.dart';

import '../../../../data/datasources/auth_datasource/auth_local_datasource.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  bool isObsecure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController passC;
  late TextEditingController confimPassC;

  @override
  void initState() {
    passC = TextEditingController();
    confimPassC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passC.dispose();
    confimPassC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackLightColor,
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Input our new password',
                  style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return DefaultField(
                    controller: passC,
                    labelText: 'Password',
                    inputType: TextInputType.text,
                    backgroundColor: AppColors.primaryDarkColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => isObsecure = !isObsecure);
                      },
                      icon: Icon(
                          isObsecure
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: AppColors.whiteColor,
                          size: 17),
                    ),
                    isObscure: isObsecure ? true : false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input our Password';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (context, setState) {
                  return DefaultField(
                    controller: confimPassC,
                    labelText: 'Confirm Password',
                    inputType: TextInputType.text,
                    isObscure: isObsecure ? true : false,
                    backgroundColor: AppColors.primaryDarkColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => isObsecure = !isObsecure);
                      },
                      icon: Icon(
                          isObsecure
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: AppColors.whiteColor,
                          size: 17),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input our Confirmation Password';
                      }

                      if (value != passC.text) {
                        return 'Password and confirm password it\'s difference';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      MessageBar.messageBar(context, message);
                      Navigation.pop();
                    },
                    success: (success) async {
                      MessageBar.messageBar(context, success);
                      await AuthLocalDatasourceImpl().removeAuthData();
                      Navigation.pushNameAndRemove(RoutesName.intro);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => DefaultButton(
                      title: 'Change Password',
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          if (passC.text.isNotEmpty &&
                              confimPassC.text.isNotEmpty &&
                              passC.text == confimPassC.text) {
                            context.read<ChangePasswordBloc>().add(
                                ChangePasswordEvent.changePassword(passC.text));
                          }
                        }
                      },
                      borderRadius: 8,
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
