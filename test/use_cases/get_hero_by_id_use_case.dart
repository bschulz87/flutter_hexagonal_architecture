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

  HeroRepository repository;

  @override
  Future<IOutputPort<UseCaseResponseMessage<Hero>>> handle(
      GetHeroByIdRequest message) async {
    ObjectPresenter<Hero> outputPort = new ObjectPresenter();
    try {
      GatewayResponse<Hero> hero =
          await this.repository.getHeroById(message.id);
      if (!hero.success)
        throw new UseCaseException('Hero not found.', hero.errors);
      outputPort.handle(new UseCaseResponseMessage<Hero>.goodResult(hero.data));
    } on UseCaseException catch (e) {
      outputPort.handle(
          new UseCaseResponseMessage<Hero>.badResult(e.errors, e.message));
    }
    return outputPort;
  }
}

class GetHeroByIdRequest
    implements IUseCaseRequest<UseCaseResponseMessage<Hero>> {
  GetHeroByIdRequest(this.id);

  final int id;
}
