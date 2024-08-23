import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/features/introduction/cubit/introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit()
      : super(const IntroductionState(bannerIndex: 0, languageIndex: 0));

  void changeBanner(int index) => emit(state.copyWith(bannerIndex: index));

  void changeLanguage(int index) => emit(state.copyWith(languageIndex: index));
}
