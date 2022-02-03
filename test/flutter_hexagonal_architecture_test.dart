import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import 'entities/hero.dart';
import 'use_cases/get_hero_by_id_use_case.dart';

void main() {
  test('gets a hero with id 4', () async {
    GetHeroByIdUseCase usecase = new GetHeroByIdUseCase();
    ObjectPresenter<Hero> presenter = new ObjectPresenter();
    await usecase.handle(new GetHeroByIdRequest(4), presenter);
    expect(presenter.success, isTrue);
    expect(presenter.error, isNull);
    expect(presenter.data, isNotNull);
    expect(presenter.data!.name, 'Flash Gordon');
  });

  test('gets an error when trying to get a hero with id 11', () async {
    GetHeroByIdUseCase usecase = new GetHeroByIdUseCase();
    ObjectPresenter<Hero> presenter = new ObjectPresenter();
    await usecase.handle(new GetHeroByIdRequest(11), presenter);
    expect(presenter.success, isFalse);
    expect(presenter.error, isNotNull);
    expect(presenter.error!.code, 'GetHeroByIdUseCase_error');
    expect(presenter.error!.description, 'Hero is not found.');
    expect(presenter.data, isNull);
  });
}
