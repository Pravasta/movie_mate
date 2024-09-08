import 'package:movie_mate/core/core.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SizedBox(
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
                  image: AssetImage(Assets.images.avatar.path),
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
                          'Pravasta Rama',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.text20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
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
                          '(+62) 822 4404 7278',
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
                          'fitrayanaf15@gmail.com',
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
      );
    }

    Widget menu() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: ProfileModel.listMenu.length,
          itemBuilder: (context, index) {
            final menu = ProfileModel.listMenu[index];

            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Image.asset(
                    menu['icon'],
                    scale: 4,
                  ),
                  trailing: index == ProfileModel.listMenu.length - 1
                      ? Switch.adaptive(
                          value: true,
                          activeColor: AppColors.primaryColor,
                          activeTrackColor: AppColors.greySecondColor,
                          inactiveTrackColor: AppColors.greySecondColor,
                          inactiveThumbColor: AppColors.primaryColor,
                          onChanged: (value) {},
                        )
                      : const Icon(Icons.arrow_forward_ios,
                          color: AppColors.whiteColor),
                  title: Text(menu['label'],
                      style:
                          AppText.text14.copyWith(fontWeight: FontWeight.bold)),
                ),
                index == ProfileModel.listMenu.length - 1
                    ? const SizedBox()
                    : const Divider(color: AppColors.greySecondColor),
              ],
            );
          },
        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
