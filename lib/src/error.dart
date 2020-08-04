class Error {
  Error(this.code, this.description)
      : assert(code != null),
        assert(description != null);

  final String code;
  final String description;
}
