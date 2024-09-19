import 'package:movie_mate/core/components/dialog/pop_up_dialog.dart';
import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/data/model/request/edit_user_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:movie_mate/features/profile/bloc/user/user_bloc.dart';

import '../bloc/edit_user_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.data});

  final UserResponseModel data;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  @override
  void initState() {
    nameC = TextEditingController(text: widget.data.name);
    emailC = TextEditingController(text: widget.data.email);
    phoneC = TextEditingController(text: widget.data.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: AppText.text18.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(
          color: AppColors.whiteColor,
        ),
      );
    }

    Widget fotoProfile() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.24,
        height: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: widget.data.photoUrl == null
                ? AssetImage(Assets.images.avatar.path)
                : NetworkImage(widget.data.photoUrl!),
          ),
        ),
      );
    }

    Widget nameField() {
      return DefaultField(
        controller: nameC,
        inputType: TextInputType.text,
        prefixIcon:
            const Icon(Icons.person, color: AppColors.whiteColor, size: 17),
      );
    }

    Widget emailField() {
      return DefaultField(
        controller: emailC,
        inputType: TextInputType.text,
        backgroundColor: AppColors.primaryDarkColor,
        prefixIcon: const Icon(Icons.email_outlined,
            color: AppColors.whiteColor, size: 17),
        isEnabled: false,
      );
    }

    Widget phoneField() {
      return DefaultField(
        inputType: TextInputType.number,
        controller: phoneC,
        prefixIcon:
            const Icon(Icons.phone, color: AppColors.whiteColor, size: 17),
      );
    }

    Widget buttonSubmit() {
      return BlocConsumer<EditUserBloc, EditUserState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) => MessageBar.messageBar(context, message),
            success: (user) {
              MessageBar.messageBar(context, 'Edit Profile Success');
              context.read<UserBloc>().add(const UserEvent.user());

              Navigation.pop();
              Navigation.pop();
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => DefaultButton(
              title: 'Edit Profile',
              onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => PopUpDialog(
                  onTap: () {
                    final user = EditUserRequestModel(
                      uid: widget.data.uid,
                      name: nameC.text,
                      phoneNumber: phoneC.text,
                      photoUrl: widget.data.photoUrl,
                    );

                    context
                        .read<EditUserBloc>()
                        .add(EditUserEvent.editUser(user));
                  },
                ),
              ),
              height: 56,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fotoProfile(),
            const SizedBox(height: 30),
            nameField(),
            const SizedBox(height: 10),
            emailField(),
            const SizedBox(height: 10),
            phoneField(),
            const SizedBox(height: 30),
            buttonSubmit(),
          ],
        ),
      ),
    );
  }
}
