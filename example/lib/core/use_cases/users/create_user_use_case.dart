import 'package:example/infrastructure/entities/user.dart';
import 'package:example/infrastructure/repositories/rent_repository.dart';
import 'package:example/infrastructure/repositories/user_repository.dart';
import 'package:example/infrastructure/repositories/video_repository.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class CreateUserUseCase
    implements
        IUseCaseRequestHandler<CreateUserRequest,
            UseCaseResponseMessage<User>> {
  CreateUserUseCase() {
    this._rentRepository = new RentRepository();
    this._userRepository = new UserRepository();
    this._videoRepository = new VideoRepository();
  }

  RentRepository _rentRepository;
  UserRepository _userRepository;
  VideoRepository _videoRepository;

  @override
  Future<void> handle(CreateUserRequest message,
      IOutputPort<UseCaseResponseMessage<User>> output) async {
    try {
      GatewayResponse<User> user = await this
          ._userRepository
          .add(new User(message.id, message.firstname, message.lastname));
      if (!user.success)
        throw new UseCaseException(
            'CreateUserUseCase_error', 'Unable to create user.');
      output.handle(new UseCaseResponseMessage<User>.goodResult(user.data));
    } on UseCaseException catch (e) {
      output.handle(new UseCaseResponseMessage<User>.badResult(
          new CoreError(e.code, e.description)));
    }
  }
}

class CreateUserRequest
    implements IUseCaseRequest<UseCaseResponseMessage<User>> {
  CreateUserRequest(this.id, this.firstname, this.lastname);

  int id;
  String firstname;
  String lastname;
}
