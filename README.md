# Flutter Hexagonal Architecture

Flutter Hexagonal Architecture provides utilities for Flutter, in the aim to develop using by clean code.

## Get started

First, you need to add the folowing dependencies to your 'pubspec.yaml':
```yaml
dependencies:
  flutter_hexagonal_architecture: any
```

## How to use utilities for projects
Here is a simple usage example. Note that an example is available in unit test file `test/flutter_hexagonal_architecture_test.dart`.

First, you can add an entity (if you try to access a database):

```dart
class Hero {
  Hero(this.id, this.name);

  final int id;
  final String name;
}
```

Next, you need to add a repository to access data:

```dart
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import 'package:queries/collections.dart';
import '../entities/hero.dart';

class HeroRepository {
  Future<GatewayResponse<Hero>> getHeroById(int id) async {
    try {
      Hero hero = // get my hero...
      if (hero == null) throw new Exception('unable to get hero by id $id.');
      return new GatewayResponse<Hero>.goodResult(hero);
    } on Exception catch (e) {
      return new GatewayResponse<Hero>.badResult([new Error('no_hero_for_id', '$e')]);
    }
  }
}
```

Here, you just get data from database or services, without changing them.

Finally, you must add a use case class:

```dart
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import '../entities/hero.dart';
import '../repository/hero_repository.dart';

class GetHeroByIdUseCase implements IUseCaseRequestHandler<GetHeroByIdRequest, UseCaseResponseMessage<Hero>> {
  GetHeroByIdUseCase() {
    this.repository = new HeroRepository();
  }

  HeroRepository repository;

  @override
  Future<void> handle(GetHeroByIdRequest message, IOutputPort<UseCaseResponseMessage<Hero>> output) async {
    try {
      GatewayResponse<Hero> hero = await this.repository.getHeroById(message.id);
      if (!hero.success)
        throw new UseCaseException('Hero not found.', hero.errors);
      output.handle(new UseCaseResponseMessage<Hero>.goodResult(hero.data));
    } on UseCaseException catch (e) {
      output.handle(new UseCaseResponseMessage<Hero>.badResult(e.errors, e.message));
    }
  }
}

class GetHeroByIdRequest implements IUseCaseRequest<UseCaseResponseMessage<Hero>> {
  GetHeroByIdRequest(this.id);

  final int id;
}
```

If you want to apply business rules, you must do it right here.
For example, in a project of video store management, you could make a method for rent a video.
You would select a user (get user by id), select a video (get video by id) and add item in the renting data table.
Those three actions are in three different repositories, but in one use case.

```dart
```

Soon, i will add content to teach how to you utilities with BlOcs.

## Feature requests and bug reports

Please file feature requests and bugs using the [github issue tracker for this repository][1].

[1]: https://github.com/maxime-aubry/flutter_hexagonal_architecture/issues