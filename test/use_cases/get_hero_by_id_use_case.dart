import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import '../entities/hero.dart';
import '../repository/hero_repository.dart';

class GetHeroByIdUseCase
    implements
        IUseCaseRequestHandler<GetHeroByIdRequest,
            UseCaseResponseMessage<Hero>> {
  GetHeroByIdUseCase() {
    this.repository = new HeroRepository();
  }

  late HeroRepository repository;

  @override
  Future<void> handle(GetHeroByIdRequest message,
      IOutputPort<UseCaseResponseMessage<Hero>> output) async {
    try {
      GatewayResponse<Hero?> hero = await this.repository.getById(message.id);
      if (!hero.success)
        throw new UseCaseException(
            'GetHeroByIdUseCase_error', 'Hero is not found.');
      output.handle(new UseCaseResponseMessage<Hero>.goodResult(hero.data!));
    } on UseCaseException catch (e) {
      output.handle(new UseCaseResponseMessage<Hero>.badResult(
          new CoreError(e.code, e.description)));
    }
  }
}

class GetHeroByIdRequest
    implements IUseCaseRequest<UseCaseResponseMessage<Hero>> {
  GetHeroByIdRequest(this.id);

  final int id;
}
