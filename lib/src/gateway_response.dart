import 'error.dart';

class GatewayResponse<TResult> {
  GatewayResponse.goodResult(TResult data) {
    this.success = true;
    this.errors = null;
    this.data = data;
  }

  GatewayResponse.badResult(List<Error> errors) {
    this.success = false;
    this.errors = errors;
    this.data = null;
  }

  bool success;
  List<Error> errors;
  TResult data;
}
