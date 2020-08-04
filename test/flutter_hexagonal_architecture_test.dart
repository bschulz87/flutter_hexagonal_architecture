import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import 'entities/hero.dart';
import 'use_cases/get_hero_by_id_use_case.dart';

void main() {
  test('gets a hero with id 4', () async {
    GetHeroByIdUseCase usecase = new GetHeroByIdUseCase();
    ObjectPresenter<Hero> presenter =
    await usecase.handle(new GetHeroByIdRequest(4));
    expect(presenter.success, isTrue);
    expect(presenter.errors, isNull);
    expect(presenter.message, isNull);
    expect(presenter.result, isNotNull);
    expect(presenter.result.name, 'Flash Gordon');
  });

  test('gets an error when trying to get a hero with id 11', () async {
    GetHeroByIdUseCase usecase = new GetHeroByIdUseCase();
    ObjectPresenter<Hero> presenter =
    await usecase.handle(new GetHeroByIdRequest(11));
    expect(presenter.success, isFalse);
    expect(presenter.errors, isNotNull);
    expect(
        presenter.errors, contains('Exception: unable to get hero by id 11.'));
    expect(presenter.message, 'Hero not found.');
    expect(presenter.result, isNull);
  });
}
