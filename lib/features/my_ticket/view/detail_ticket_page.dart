import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/core/extensions/num_ext.dart';
import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import 'widgets/separator.dart';

class DetailTicketPage extends StatelessWidget {
  const DetailTicketPage({super.key, required this.data});

  final OrderModel data;

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        centerTitle: true,
        leading: BackButton(
          color: AppColors.whiteColor,
          onPressed: () =>
              Navigation.pushNameAndRemove(RoutesName.mainNavigation),
        ),
        title: Text(
          'My Ticket',
          style: AppText.text20,
        ),
      );
    }

    Widget header() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: data.image == null
                ? Image.asset(
                    Assets.images.banner.path,
                    fit: BoxFit.cover,
                    width: context.deviceWidth * 1 / 3,
                    height: context.deviceHeight * 1 / 4.5,
                  )
                : Image.network(
                    '${Variable.baseImageUrl}${data.image}',
                    fit: BoxFit.cover,
                    width: context.deviceWidth * 1 / 3,
                    height: context.deviceHeight * 1 / 4.5,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(data.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppText.text16.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        color: AppColors.blackColor, size: 15),
                    const SizedBox(width: 10),
                    Text(
                      data.duration ?? '',
                      style:
                          AppText.text12.copyWith(color: AppColors.blackColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.movie,
                        color: AppColors.blackColor, size: 15),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        data.genres!.map((e) => e).join(', '),
                        style: AppText.text12
                            .copyWith(color: AppColors.blackColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget detailed() {
      return Row(
        children: [
          Expanded(
              child: Center(
            child: Row(
              children: [
                SizedBox(
                    width: context.deviceWidth * 1 / 9,
                    height: context.deviceWidth * 1 / 9,
                    child: Image.asset(
                      Assets.icons.calendar.path,
                      fit: BoxFit.contain,
                    )),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data.selectedTime}\'',
                        style: AppText.text14.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(data.selectedDate ?? '',
                        style: AppText.text14.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ],
            ),
          )),
          const SizedBox(width: 10),
          Expanded(
              child: Row(
            children: [
              SizedBox(
                  width: context.deviceWidth * 1 / 9,
                  height: context.deviceWidth * 1 / 9,
                  child: Image.asset(
                    Assets.icons.seating.path,
                    fit: BoxFit.contain,
                  )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Section ${data.sectionSeat!.map((e) => e).join(', ')}',
                      style: AppText.text14.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      )),
                  Text('Seat ${data.selectedSeat!.map((e) => e).join(', ')}',
                      style: AppText.text14.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ],
          )),
        ],
      );
    }

    Widget detailedTicket() {
      return Column(
        children: [
          Row(
            children: [
              const Icon(Icons.monetization_on_outlined),
              const SizedBox(width: 10),
              Text(int.parse(data.price!).currencyFormatRp,
                  style: AppText.text14.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 10),
              Text(data.cinemaName ?? '',
                  style: AppText.text14.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.note_add_outlined),
              const SizedBox(width: 10),
              Text(
                  'Show this QR code to the ticket counter to\nreceive your ticket',
                  maxLines: 2,
                  style: AppText.text12.copyWith(
                    color: AppColors.blackColor,
                  )),
            ],
          ),
        ],
      );
    }

    Widget barcode() {
      return Container(
        width: context.deviceWidth,
        padding: const EdgeInsets.all(20),
        height: context.deviceHeight * 1 / 5,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: AppColors.whiteColor),
        child: SfBarcodeGenerator(
          value: 'Order ID: ${data.orderId}',
          symbology: Code128(),
          showValue: true,
          textStyle: AppText.text12.copyWith(color: AppColors.blackColor),
        ),
      );
    }

    Widget designCircular() {
      return Container(
        width: context.deviceWidth,
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 25,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: AppColors.blackColor,
              ),
            ),
            const Expanded(
                child: MySeparator(
              color: AppColors.blackColor,
              height: 2,
            )),
            Container(
              width: 25,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColors.whiteColor),
              child: Column(
                children: [
                  header(),
                  const SizedBox(height: 25),
                  detailed(),
                  const SizedBox(height: 15),
                  const Divider(color: AppColors.greyLightColor),
                  const SizedBox(height: 15),
                  detailedTicket(),
                ],
              ),
            ),
            designCircular(),
            // Barcode
            barcode(),
          ],
        ),
      ),
    );
  }
}
