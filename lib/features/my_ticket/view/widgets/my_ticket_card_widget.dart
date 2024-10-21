import 'package:movie_mate/data/model/response/order_model.dart';

import '../../../../core/core.dart';
import '../../../../core/variables/variable.dart';

class MyTicketCardWidget extends StatelessWidget {
  const MyTicketCardWidget({super.key, required this.data});

  final OrderModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Id : ${data.orderId}',
            style: AppText.text16.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.greySecondColor,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: data.image != null
                    ? Image.network(
                        '${Variable.baseImageUrl}${data.image}',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.30,
                      )
                    : Image.asset(
                        Assets.images.banner.path,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.30,
                      ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.text16
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star,
                            color: AppColors.primaryColor, size: 15),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(data.genres!.map((e) => e).join(', '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.text12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: AppColors.greyLightColor, size: 15),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${data.cinemaName} | ${data.cinemaLocation}',
                            style: AppText.text12,
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
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
