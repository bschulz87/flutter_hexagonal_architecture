/// [InfraError] provides errors to the client.
/// {@category Infrastructure}
class InfraError {
  InfraError(this.code, this.description)
      : assert(code != null),
        assert(description != null);

  /// [code] is the error code. It can be used to identity the error.
  final String code;

  /// [description] is the default error message.
  final String description;
}
