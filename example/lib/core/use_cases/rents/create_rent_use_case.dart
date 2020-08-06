import 'package:example/infrastructure/entities/rents.dart';
import 'package:example/infrastructure/entities/user.dart';
import 'package:example/infrastructure/entities/video.dart';
import 'package:example/infrastructure/repositories/rent_repository.dart';
import 'package:example/infrastructure/repositories/user_repository.dart';
import 'package:example/infrastructure/repositories/video_repository.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class CreateRentUseCase
    implements
        IUseCaseRequestHandler<CreateRentRequest,
            UseCaseResponseMessage<Rent>> {
  CreateRentUseCase() {
    this._rentRepository = new RentRepository();
    this._userRepository = new UserRepository();
    this._videoRepository = new VideoRepository();
  }

  RentRepository _rentRepository;
  UserRepository _userRepository;
  VideoRepository _videoRepository;

  @override
  Future<void> handle(CreateRentRequest message,
      IOutputPort<UseCaseResponseMessage<Rent>> output) async {
    try {
      GatewayResponse<User> user =
          await this._userRepository.getById(message.userId);
      if (!user.success)
        throw new UseCaseException(
            'CreateRentUseCase_error', 'Unable to get user.');

      GatewayResponse<Video> video =
          await this._videoRepository.getById(message.videoId);
      if (!video.success)
        throw new UseCaseException(
            'CreateRentUseCase_error', 'Unable to get video.');

      GatewayResponse<Rent> rent = await this
          ._rentRepository
          .add(new Rent(message.userId, message.videoId, message.rentDate));
      if (!rent.success)
        throw new UseCaseException(
            'CreateRentUseCase_error', 'Unable to create rent.');
      output.handle(new UseCaseResponseMessage<Rent>.goodResult(rent.data));
    } on UseCaseException catch (e) {
      output.handle(new UseCaseResponseMessage<Rent>.badResult(
          new CoreError(e.code, e.description)));
    }
  }
}

class CreateRentRequest
    implements IUseCaseRequest<UseCaseResponseMessage<Rent>> {
  CreateRentRequest(this.userId, this.videoId, this.rentDate);

  int userId;
  int videoId;
  DateTime rentDate;
}
