import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

import 'i_output_port.dart';
import 'i_use_case_request.dart';

/// [IUseCaseRequestHandler] is an interface for the use case. It defines the type of the response.
/// {@category Core}
abstract class IUseCaseRequestHandler<
    TUseCaseRequest extends IUseCaseRequest<TUseCaseResponse>,
    TUseCaseResponse> {
  /// This method contains the use case to execute.
  /// This method need a request object, this on contains many parameters for the treatment.
  Future<void> handle(
      TUseCaseRequest message, IOutputPort<TUseCaseResponse> output);
}
