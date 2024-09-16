import 'package:movie_mate/core/components/message/message_bar.dart';
import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/data/datasources/auth_datasource/auth_local_datasource.dart';
import 'package:movie_mate/features/profile/view/widget/change_password_dialog.dart';

import '../../auth/bloc/logout/logout_bloc.dart';
import '../bloc/user/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (user) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.width * 0.24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: user.photoUrl == null
                            ? AssetImage(Assets.images.avatar.path)
                            : NetworkImage(user.photoUrl!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.text20.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () => Navigation.pushName(
                                      RoutesName.editProfile,
                                      arguments: user,
                                    ),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppColors.greyLightColor,
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                color: AppColors.whiteColor, size: 17),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.phoneNumber ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.text12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined,
                                color: AppColors.whiteColor, size: 17),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.email ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.text12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget menu() {
      Widget listMenu(String imageUrl, String label, VoidCallback onTap) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: onTap,
          leading: Image.asset(
            imageUrl,
            scale: 4,
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, color: AppColors.whiteColor),
          title: Text(label,
              style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            listMenu(Assets.icons.ticket.path, 'My Ticket', () {}),
            const Divider(color: AppColors.greySecondColor),
            listMenu(Assets.icons.shoppingCart.path, 'Payment History', () {}),
            const Divider(color: AppColors.greySecondColor),
            listMenu(Assets.icons.translate.path, 'Change Language', () {}),
            const Divider(color: AppColors.greySecondColor),
            listMenu(Assets.icons.lock.path, 'Change Password', () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const ChangePasswordDialog();
                  });
            }),
            const Divider(color: AppColors.greySecondColor),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Image.asset(
                Assets.icons.faceId.path,
                scale: 4,
              ),
              trailing: Switch.adaptive(
                value: true,
                activeColor: AppColors.primaryColor,
                activeTrackColor: AppColors.greySecondColor,
                inactiveTrackColor: AppColors.greySecondColor,
                inactiveThumbColor: AppColors.primaryColor,
                onChanged: (value) {},
              ),
              title: Text('FaceID/Touch ID',
                  style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }

    Widget logout() {
      return BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) => MessageBar.messageBar(context, message),
            success: (data) async {
              await AuthLocalDatasourceImpl().removeAuthData();
              Navigation.pushNameAndRemove(RoutesName.intro);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => GestureDetector(
              onTap: () {
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
              },
              child: SizedBox(
                width: context.deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_outlined,
                        color: AppColors.whiteColor, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: AppText.text14.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: Column(
            children: [
              header(),
              menu(),
              const Spacer(),
              logout(),
            ],
          ),
        ),
      ),
    );
  }
}
