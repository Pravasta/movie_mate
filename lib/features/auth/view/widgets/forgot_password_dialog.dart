import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';

import '../../bloc/forgot_password/forgot_password_bloc.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailC;

  @override
  void initState() {
    emailC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
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
              Text('Input our Email',
                  style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              DefaultField(
                controller: emailC,
                labelText: 'Email',
                inputType: TextInputType.text,
                backgroundColor: AppColors.primaryDarkColor,
                prefixIcon: const Icon(Icons.email_outlined,
                    color: AppColors.whiteColor, size: 17),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Input our Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      MessageBar.messageBar(context, message);
                      Navigation.pop();
                    },
                    success: (success) {
                      MessageBar.messageBar(context, success);
                      Navigation.pop();
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => DefaultButton(
                      title: 'Forgot Password',
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          if (emailC.text.isNotEmpty) {
                            context.read<ForgotPasswordBloc>().add(
                                ForgotPasswordEvent.forgotPassword(
                                    emailC.text));
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
