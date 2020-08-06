/// [UseCaseException] is an exception to use into a use case.
/// [code] and [description] are returned to the client using by [CoreError] into a [UseCaseResponseMessage] and presenters.
/// [code] property can be used to get a localized error message, while [description] is used only by developers into the console.
/// {@category Core}
class UseCaseException implements Exception {
  UseCaseException(this.code, this.description);

  /// [code] is the error code. It can be used to get a localized error message.
  final String code;

  /// [description] is the default error message.
  final String description;
}
