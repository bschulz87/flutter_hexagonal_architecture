import 'package:example/infrastructure/entities/video.dart';
import 'package:example/infrastructure/repositories/rent_repository.dart';
import 'package:example/infrastructure/repositories/user_repository.dart';
import 'package:example/infrastructure/repositories/video_repository.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class CreateVideoUseCase
    implements
        IUseCaseRequestHandler<CreateVideoRequest,
            UseCaseResponseMessage<Video>> {
  CreateVideoUseCase() {
    this._rentRepository = new RentRepository();
    this._userRepository = new UserRepository();
    this._videoRepository = new VideoRepository();
  }

  RentRepository _rentRepository;
  UserRepository _userRepository;
  VideoRepository _videoRepository;

  @override
  Future<void> handle(CreateVideoRequest message,
      IOutputPort<UseCaseResponseMessage<Video>> output) async {
    try {
      GatewayResponse<Video> video =
          await this._videoRepository.add(new Video(message.id, message.title));
      if (!video.success)
        throw new UseCaseException(
            'CreateVideoUseCase_error', 'Unable to create video.');
      output.handle(new UseCaseResponseMessage<Video>.goodResult(video.data));
    } on UseCaseException catch (e) {
      output.handle(new UseCaseResponseMessage<Video>.badResult(
          new CoreError(e.code, e.description)));
    }
  }
}

class CreateVideoRequest
    implements IUseCaseRequest<UseCaseResponseMessage<Video>> {
  CreateVideoRequest(this.id, this.title);

  int id;
  String title;
}
