import 'error.dart';
import 'package:queries/collections.dart';

class UseCaseResponseMessage<TResult> {
  UseCaseResponseMessage.goodResult(TResult result) {
    this.success = true;
    this.errors = null;
    this.message = null;
    this.result = result;
  }

  UseCaseResponseMessage.badResult(List<Error> errors, String message) {
    this.success = false;
    this.errors = Collection(errors).select((e) => e.description).toList();
    this.message = message;
    this.result = null;
  }

  bool success;
  String message;
  List<String> errors;
  TResult result;
}
