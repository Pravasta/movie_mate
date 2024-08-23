import 'package:movie_mate/core/import.dart';

class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 1 / 5,
          width: MediaQuery.of(context).size.width * 1 / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                data['images'],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(data['label'], style: AppText.text14),
      ],
    );
  }
}
