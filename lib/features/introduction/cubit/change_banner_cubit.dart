import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBannerCubit extends Cubit<int> {
  ChangeBannerCubit() : super(0);

  void changeBanner(int index) => emit(index);
}
