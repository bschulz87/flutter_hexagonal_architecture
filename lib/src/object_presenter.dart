import 'i_presenter.dart';
import 'use_case_response_message.dart';

class ObjectPresenter<TResult> implements IPresenter<TResult> {
  @override
  List<String> errors;

  @override
  String message;

  @override
  TResult result;

  @override
  bool success;

  @override
  void handle(UseCaseResponseMessage<TResult> response) {
    this.success = response.success;
    this.errors = response.errors;
    this.message = response.message;
    this.result = response.result;
  }
}
