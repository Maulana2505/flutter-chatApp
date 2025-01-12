
abstract class Failure {
  final String massage;
  Failure({
    required this.massage,
  });
}

class ServerFailure extends Failure{
  ServerFailure({required super.massage});
}