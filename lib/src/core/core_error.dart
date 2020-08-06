/// [CoreError] provides errors to the client.
/// [code] and [description] are returned to the client into a [UseCaseResponseMessage] and presenters.
/// [code] property can be used to get a localized error message, while [description] is used only by developers into the console.
/// {@category Core}
class CoreError {
  CoreError(this.code, this.description)
      : assert(code != null),
        assert(description != null);

  /// [code] is the error code. It can be used to get a localized error message.
  final String code;

  /// [description] is the default error message.
  final String description;
}
