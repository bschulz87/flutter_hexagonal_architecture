import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';
import 'package:queries/collections.dart';
import '../entities/hero.dart';

class HeroRepository {
  Future<GatewayResponse<Hero>> getHeroById(int id) async {
    try {
      IEnumerable<Hero> heroes = Collection([
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
      ]);
      Hero hero = heroes.where((h) => h.id == id).singleOrDefault();
      if (hero == null) throw new Exception('unable to get hero by id $id.');
      return new GatewayResponse<Hero>.goodResult(hero);
    } on Exception catch (e) {
      return new GatewayResponse<Hero>.badResult(
          [new Error('no_hero_for_id', '$e')]);
    }
  }
}
