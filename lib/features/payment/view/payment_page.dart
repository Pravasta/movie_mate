import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/extensions/num_ext.dart';
import 'package:movie_mate/core/extensions/time_ext.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/features/payment/model/payment_model.dart';
import 'package:movie_mate/features/payment/view/widget/payment_qris_dialog.dart';
import 'package:movie_mate/features/payment/view/widget/payment_card_widget.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    int selectedPayment = 0;
    String paymentName = '';

    Widget bannerMovieSelected() {
      // return const WatchlistMovieCard();
      return const SizedBox();
    }

    Widget detailOrder() {
      return Column(
        children: [
          Row(
            children: [
              Text('Order ID', style: AppText.text14),
              const Spacer(),
              Text(order.orderId ?? '',
                  style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('Seat', style: AppText.text14),
              const Spacer(),
              Text(order.selectedSeat!.map((e) => e).join(', '),
                  style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: DefaultField(
                  hintText: 'discount code',
                  prefixIcon: Image.asset(
                    Assets.icons.discount.path,
                    scale: 4,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: DefaultButton(
                  title: 'Apply',
                  onTap: () {},
                  borderRadius: 12,
                  height: 50,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.whiteColor, thickness: 0.2),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('Total', style: AppText.text14),
              const Spacer(),
              Text(int.tryParse(order.price!)!.currencyFormatRp,
                  style: AppText.text22.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor)),
            ],
          ),
        ],
      );
    }

    Widget paymentMethod() {
      return SizedBox(
        width: context.deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Method',
                style: AppText.text18.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: PaymentModel.paymentModel
                      .map((e) => PaymentCardWidget(
                            title: e['title'],
                            imageUrl: e['image_url'],
                            isActive: selectedPayment == e['index'],
                            onPressed: () {
                              setState(() {
                                selectedPayment = e['index'];
                                paymentName = e['title'];
                              });
                            },
                          ))
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              width: context.deviceWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryDarkColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child:
                        Text('Complete your payment in', style: AppText.text12),
                  ),
                  Countdown(
                    seconds: 900,
                    build: (context, time) {
                      return Text(
                        time.timeFormatMMSS,
                        style: AppText.text14.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                    onFinished: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: AppColors.whiteColor),
        title: Text(
          'Payment',
          style: AppText.text20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            bannerMovieSelected(),
            detailOrder(),
            const SizedBox(height: 20),
            paymentMethod(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: DefaultButton(
          title: 'Continue',
          height: 50,
          onTap: () {
            final data = OrderModel(
              orderId: order.orderId,
              cinemaLocation: order.cinemaLocation,
              cinemaName: order.cinemaName,
              duration: order.duration,
              genres: order.genres,
              price: order.price,
              image: order.image,
              sectionSeat: order.sectionSeat,
              selectedDate: order.selectedDate,
              selectedSeat: order.selectedSeat,
              selectedTime: order.selectedTime,
              title: order.title,
              paymentMethod: paymentName,
            );

            switch (selectedPayment) {
              case 0:
                print(paymentName);
              case 1:
                Navigation.pushName(RoutesName.transferBankPage,
                    arguments: data);
              case 2:
                showDialog(
                  context: context,
                  builder: (context) => PaymentQrisDialog(order: data),
                );
              default:
                showDialog(
                  context: context,
                  builder: (context) => PaymentQrisDialog(order: data),
                );
            }
          },
        ),
      ),
    );
  }
}
