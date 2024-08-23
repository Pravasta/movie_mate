import 'package:movie_mate/core/import.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ticket'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const TicketCardWidget();
            },
          )),
    );
  }
}
