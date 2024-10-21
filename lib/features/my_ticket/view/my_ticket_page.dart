import 'package:movie_mate/core/core.dart';
import 'package:movie_mate/features/my_ticket/view/widgets/my_ticket_card_widget.dart';

import '../bloc/get_all_ticket_orders_bloc.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetAllTicketOrdersBloc>()
        .add(const GetAllTicketOrdersEvent.getAllTicketOrders());
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        title: Text('My Ticket', style: AppText.text22),
        centerTitle: true,
        leading: const BackButton(
          color: AppColors.whiteColor,
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<GetAllTicketOrdersBloc, GetAllTicketOrdersState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => Center(
                child: Text(
                  'Ticket not Found\nOrder now to get Ticket....',
                  textAlign: TextAlign.center,
                  style: AppText.text20.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              error: (error) => Center(
                child: Text(
                  error,
                  style: AppText.text22.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final datas = data[index];

                    return GestureDetector(
                        onTap: () => Navigation.pushName(
                              RoutesName.detailTicket,
                              arguments: datas,
                            ),
                        child: MyTicketCardWidget(data: datas));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
