import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/extensions/num_ext.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/features/select_seat/model/seat_model.dart';
import 'package:movie_mate/features/select_seat/view/widgets/seat_widget.dart';
import 'package:movie_mate/features/select_seat/view/widgets/select_data_widget.dart';
import 'package:movie_mate/features/select_seat/view/widgets/select_time_widget.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({super.key, required this.orderData});

  final OrderModel orderData;

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  int indexTime = 0;
  String selectedTime = '09:00';

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
      return SizedBox(
        width: context.deviceWidth,
        child: Column(
          children: [
            Text('Select Date & Time',
                style: AppText.text16.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const SelectDataWidget(),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: SeatModel.dataTime
                          .map(
                            (e) => SelectTimeWidget(
                              isActive: indexTime == e['index'],
                              onPressed: () {
                                setState(() {
                                  indexTime = e['index'];
                                  selectedTime = e['time'];
                                });
                              },
                              title: e['time'],
                            ),
                          )
                          .toList()),
                );
              },
            )
          ],
        ),
      );
    }

    Widget bottomNavbar() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.1, color: AppColors.whiteColor),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
                child: Text(210000.currencyFormatRp,
                    style: AppText.text22.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold))),
            Expanded(
              child: DefaultButton(
                title: 'Select Seat',
                height: 50,
                onTap: () {
                  final order = OrderModel(
                    orderId: widget.orderData.orderId,
                    cinemaLocation: widget.orderData.cinemaLocation,
                    cinemaName: widget.orderData.cinemaName,
                    duration: widget.orderData.duration,
                    image: widget.orderData.image,
                    genres: widget.orderData.genres,
                    title: widget.orderData.title,
                    sectionSeat: ['1'],
                    selectedSeat: ['A7, A8'],
                    selectedDate: '10 Dec',
                    selectedTime: selectedTime,
                    price: '210000',
                  );

                  Navigation.pushName(
                    RoutesName.payment,
                    arguments: order,
                  );
                },
              ),
            ),
          ],
        ),
      );
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
      body: ListView(
        shrinkWrap: true,
        children: [
          screen(),
          seating(),
          const SizedBox(height: 20),
          date(),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: bottomNavbar(),
    );
  }
}
