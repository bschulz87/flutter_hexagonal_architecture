/// [IOutputPort] is an interface used to execute a use case.
/// {@category Core}
abstract class IOutputPort<TUseCaseResponse> {
  void handle(TUseCaseResponse response);
}
