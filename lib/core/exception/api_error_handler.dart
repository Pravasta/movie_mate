import 'package:movie_mate/core/exception/api_exception.dart';

class ApiErrorHandler {
  static Exception handleError({
    required int statusCode,
    required String error,
  }) {
    switch (statusCode) {
      case 400:
        return BadRequestException();
      case 401:
        return UnauthorizedException();
      case 402:
        return PaymentRequiredException();
      case 403:
        return ForbiddenException();
      case 404:
        return NotFoundException();
      case 405:
        return MethodNotAllowedException();
      case 406:
        return NotAcceptableException();
      case 408:
        return RequestTimeoutException();
      case 500:
        return InternalServerErrorException();
      case 501:
        return NotImplementedException();
      case 502:
        return BadGatewayException();
      default:
        return ApiException(message: error);
    }
  }
}
