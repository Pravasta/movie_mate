import 'dart:async';

import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/features/payment/bloc/check_payment_status/check_payment_status_bloc.dart';
import 'package:movie_mate/features/payment/bloc/create_order/create_order_bloc.dart';
import 'package:movie_mate/features/payment/bloc/generate_qris/generate_qris_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../../../core/core.dart';

class PaymentQrisDialog extends StatefulWidget {
  const PaymentQrisDialog({super.key, required this.order});

  final OrderModel order;

  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  Timer? timer;

  @override
  void initState() {
    context.read<GenerateQrisBloc>().add(GenerateQrisEvent.generateQrCode(
        widget.order.orderId ?? '', int.parse(widget.order.price!)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Show this QR code to customer'),
          SizedBox(
            height: 200,
            width: 200,
            child:
                BlocListener<CheckPaymentStatusBloc, CheckPaymentStatusState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (message) {
                    timer?.cancel();
                    final orderModel = widget.order;

                    context
                        .read<CreateOrderBloc>()
                        .add(CreateOrderEvent.createOrdert(orderModel));
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => Navigation.pushReplacement(RoutesName.detailTicket,
                          arguments: orderModel),
                    );
                  },
                );
              },
              child: BlocConsumer<GenerateQrisBloc, GenerateQrisState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error) => Center(
                      child: Text(error, style: AppText.text14),
                    ),
                    success: (data) {
                      return Image.network(
                        data.actions!.first.url!,
                      );
                    },
                  );
                },
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      const onSec = Duration(seconds: 2);
                      timer = Timer.periodic(
                        onSec,
                        (timer) {
                          print(data.actions!.first.url);
                          context.read<CheckPaymentStatusBloc>().add(
                              CheckPaymentStatusEvent.checkPaymentStatus(
                                  data.transactionId!));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Countdown(
            seconds: 60,
            build: (context, time) => Text.rich(
              TextSpan(
                text: 'Update after ',
                children: [
                  TextSpan(
                    text: '${time.toInt()}s.',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            onFinished: () {},
          ),
        ],
      ),
    );
  }
}
