class Failure {
  final String message;

  Failure({required this.message});
}

class ConnectionFailure extends Failure {
  ConnectionFailure({super.message = 'Failed to connect to the network'});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = ''});
}
