import 'i_presenter.dart';
import '../core/core_error.dart';
import '../core/use_case_response_message.dart';

/// [Presenter] is an object containing the result of use cases.
/// It has a generic type of wanted value.
class ObjectPresenter<TResult> implements IPresenter<TResult> {
  /// [success] is boolean property that informs the client if the use case worked or not.
  @override
  late bool success;

  /// [error] is a [CoreError] object that provides an error to the client when use case fails.
  @override
  CoreError? error;

  /// [data] is a generic type that provides a result to the client.
  @override
  TResult? data;

  /// This is the method that return wanted value to the client.
  /// The received value from use case is raw data. Here, you can transform them to use them on the client side.
  /// For example, you can transform a byte array in File, or an entity to a viewmodel...
  @override
  void handle(UseCaseResponseMessage<TResult> response) {
    this.success = response.success;
    this.error = response.error;
    this.data = response.data;
  }
}
