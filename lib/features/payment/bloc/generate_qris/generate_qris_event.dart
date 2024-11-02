part of 'generate_qris_bloc.dart';

@freezed
class GenerateQrisEvent with _$GenerateQrisEvent {
  const factory GenerateQrisEvent.started() = _Started;
  const factory GenerateQrisEvent.generateQrCode(
      String orderId, int grossAmount) = _GenerateQrCode;
}
