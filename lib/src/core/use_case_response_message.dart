import 'core_error.dart';

/// [UseCaseResponseMessage] is an object that receive data to return to the client.
/// {@category Core}
class UseCaseResponseMessage<TResult> {
  /// [goodResult] is a named constructor used to return a good result to the client.
  /// [success] will be valorized to true, [error] will be null and [data] will receive the wanted data object.
  UseCaseResponseMessage.goodResult(TResult data) {
    this.success = true;
    this.error = null;
    this.data = data;
  }

  /// [badResult] is a named constructor used to return a bad result to the client.
  /// [success] will be valorized to false, [error] will be receive a [CodeError] object and [data] will be null.
  UseCaseResponseMessage.badResult(CoreError error) {
    this.success = false;
    this.error = error;
    this.data = null;
  }

  /// [success] is boolean property that informs the client if the use case worked or not.
  late bool success;

  /// [error] is a [CoreError] object that provides an error to the client when use case fails.
  CoreError? error;

  /// [data] is a generic type that provides a result to the client.
  TResult? data;
}
