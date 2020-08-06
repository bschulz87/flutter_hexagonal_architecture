import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import '../entities/hero.dart';

class HeroRepository {
  List<Hero> heroes = [
    new Hero(1, 'Luke Skywalker'),
    new Hero(2, 'Superman'),
    new Hero(3, 'Batman'),
    new Hero(4, 'Flash Gordon'),
    new Hero(5, 'Marty Mc Fly'),
    new Hero(6, 'Shazam'),
    new Hero(7, 'Iron Man'),
    new Hero(8, 'Flash'),
    new Hero(9, 'Mr Incredible'),
    new Hero(10, 'Howard the duck'),
  ];

  Future<GatewayResponse<Hero>> getById(int id) async {
    try {
      // search the hero
      Hero hero;
      for (int i = 0; i <= this.heroes.length; i++) {
        if (this.heroes[i].id == id) {
          hero = this.heroes[i];
          break;
        }
      }

      if (hero == null) throw new Exception('unable to get hero with id $id.');
      return new GatewayResponse<Hero>.goodResult(hero);
    } on Exception catch (e) {
      return new GatewayResponse<Hero>.badResult(
          new InfraError('HeroRepository_getById_error', e.toString()));
    }
  }
}
