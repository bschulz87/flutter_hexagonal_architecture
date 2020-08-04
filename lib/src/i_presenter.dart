import 'i_output_port.dart';
import 'use_case_response_message.dart';

abstract class IPresenter<TResult>
    extends IOutputPort<UseCaseResponseMessage<TResult>> {
  bool success;
  String message;
  List<String> errors;
  TResult result;
}
