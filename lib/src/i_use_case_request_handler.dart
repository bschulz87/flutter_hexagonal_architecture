import 'i_output_port.dart';
import 'i_use_case_request.dart';

abstract class IUseCaseRequestHandler<
    TUseCaseRequest extends IUseCaseRequest<TUseCaseResponse>,
    TUseCaseResponse> {
  Future<IOutputPort<TUseCaseResponse>> handle(TUseCaseRequest message);
}
