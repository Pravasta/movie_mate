import 'package:movie_mate/core/core.dart';

class PopUpDialog extends StatelessWidget {
  const PopUpDialog({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackLightColor,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Are you sure ? ',
                style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: DefaultButton(
                    title: 'Cancel',
                    onTap: () => Navigation.pop(),
                    backgroundColor: AppColors.greyLightColor,
                    borderRadius: 8,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: DefaultButton(
                    title: 'Yes',
                    onTap: onTap,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
