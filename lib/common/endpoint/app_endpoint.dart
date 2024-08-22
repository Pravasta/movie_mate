class AppEndpoint {
  final String _baseUrl;

  AppEndpoint({required String baseUrl}) : _baseUrl = baseUrl;

  factory AppEndpoint.create() {
    return AppEndpoint(baseUrl: 'baseUrl');
  }
}
