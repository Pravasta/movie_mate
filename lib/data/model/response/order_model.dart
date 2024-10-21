class OrderModel {
  final String? orderId;
  final String? title;
  final String? duration;
  final String? image;
  final List<String>? genres;
  final String? selectedTime;
  final String? selectedDate;
  final List<String>? sectionSeat;
  final List<String>? selectedSeat;
  final String? price;
  final String? cinemaLocation;
  final String? cinemaName;
  final String? paymentMethod;

  OrderModel({
    this.orderId,
    this.title,
    this.duration,
    this.image,
    this.genres,
    this.selectedTime,
    this.selectedDate,
    this.sectionSeat,
    this.selectedSeat,
    this.price,
    this.cinemaLocation,
    this.cinemaName,
    this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'title': title,
      'duration': duration,
      'image': image,
      'genres': genres,
      'selectedTime': selectedTime,
      'selectedDate': selectedDate,
      'sectionSeat': sectionSeat,
      'selectedSeat': selectedSeat,
      'price': price,
      'cinemaLocation': cinemaLocation,
      'cinemaName': cinemaName,
      'paymentMethod': paymentMethod,
    };
  }

  factory OrderModel.fromFirestore(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['orderId'] as String?,
      title: data['title'] as String?,
      duration: data['duration'] as String?,
      image: data['image'] as String?,
      genres: (data['genres'] as List<dynamic>?)
          ?.map((genre) => genre as String)
          .toList(),
      selectedTime: data['selectedTime'] as String?,
      selectedDate: data['selectedDate'] as String?,
      sectionSeat: (data['sectionSeat'] as List<dynamic>?)
          ?.map((seat) => seat as String)
          .toList(),
      selectedSeat: (data['selectedSeat'] as List<dynamic>?)
          ?.map((seat) => seat as String)
          .toList(),
      price: data['price'] as String?,
      cinemaLocation: data['cinemaLocation'] as String?,
      cinemaName: data['cinemaName'] as String?,
      paymentMethod: data['paymentMethod'] as String?,
    );
  }
}
