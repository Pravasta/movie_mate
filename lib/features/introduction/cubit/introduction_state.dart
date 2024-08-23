import 'package:equatable/equatable.dart';

class IntroductionState extends Equatable {
  final int bannerIndex;
  final int languageIndex;

  const IntroductionState(
      {required this.bannerIndex, required this.languageIndex});

  IntroductionState copyWith({int? bannerIndex, int? languageIndex}) {
    return IntroductionState(
      bannerIndex: bannerIndex ?? this.bannerIndex,
      languageIndex: languageIndex ?? this.languageIndex,
    );
  }

  @override
  List<Object?> get props => [bannerIndex, languageIndex];
}
