import '../infrastructure/infra_error.dart';

/// [GatewayResponse] is an object that returns data from the repositories or services to the use cases.
/// {@category Infrastructure}
class GatewayResponse<TResult> {
  /// [goodResult] is a named constructor used to return a good result to the use case.
  /// [success] will be valorized to true, [error] will be null and [data] will receive the wanted data object.
  GatewayResponse.goodResult(TResult data) {
    this.success = true;
    this.error = null;
    this.data = data;
  }

  /// [badResult] is a named constructor used to return a bad result to the use case.
  /// [success] will be valorized to false, [error] will be receive a [InfraError] object and [data] will be null.
  GatewayResponse.badResult(InfraError error) {
    this.success = false;
    this.error = error;
    this.data = null;
  }

  /// [success] is boolean property that informs the client if the use case worked or not.
  late bool success;

  /// [error] is a [InfraError] object that provides an error to the client when use case fails.
  InfraError? error;

  /// [data] is a generic type that provides a result to the client.
  TResult? data;
}
