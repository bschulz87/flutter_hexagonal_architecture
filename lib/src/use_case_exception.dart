import 'error.dart';

class UseCaseException implements Exception {
  UseCaseException(this.message, this.errors);

  final String message;
  final List<Error> errors;
}
