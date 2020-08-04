abstract class IOutputPort<TUseCaseResponse> {
  void handle(TUseCaseResponse response);
}
