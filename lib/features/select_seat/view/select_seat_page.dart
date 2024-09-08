import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/select_seat/view/widgets/seat_widget.dart';

class SelectSeatPage extends StatelessWidget {
  const SelectSeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget screen() {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: context.deviceWidth,
            height: context.deviceHeight * 1 / 10,
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            )),
            child: Text('Screen',
                style: AppText.text16, textAlign: TextAlign.center),
          ));
    }

    Widget seating() {
      return Container(
        width: context.deviceWidth,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int j = 0; j < 9; j++)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 2; i < 13; i++)
                        SeatWidget(
                          title: '${String.fromCharCode(65 + j)} $i',
                        ),
                    ],
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: context.deviceWidth * 1 / 17,
                      height: context.deviceWidth * 1 / 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.greySecondColor,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text('Available', style: AppText.text12),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: context.deviceWidth * 1 / 17,
                      height: context.deviceWidth * 1 / 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text('Reserved', style: AppText.text12),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: context.deviceWidth * 1 / 17,
                      height: context.deviceWidth * 1 / 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text('Selected', style: AppText.text12),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget date() {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: AppColors.whiteColor),
        title: Text(
          'Select Seat',
          style: AppText.text20,
        ),
      ),
      body: Column(
        children: [
          screen(),
          seating(),
          date(),
        ],
      ),
    );
  }
}
