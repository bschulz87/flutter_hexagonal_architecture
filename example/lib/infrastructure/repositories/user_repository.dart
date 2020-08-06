import 'package:example/infrastructure/entities/user.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class UserRepository {
  static List<User> users = [];

  User _getUser(int id) {
    User result;
    for (int i = 0; i <= UserRepository.users.length; i++) {
      if (UserRepository.users[i].id == id) {
        result = UserRepository.users[i];
        break;
      }
    }
    if (result == null)
      throw new Exception('unable to get user with userId $id.');
    return result;
  }

  Future<GatewayResponse<User>> getById(int id) async {
    try {
      User result = _getUser(id);
      return new GatewayResponse<User>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<User>.badResult(
        new InfraError('UserRepository_getById_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<List<User>>> get() async {
    try {
      if (UserRepository.users == null)
        throw new Exception('unable to get users.');
      return new GatewayResponse<List<User>>.goodResult(UserRepository.users);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<List<User>>.badResult(
        new InfraError('UserRepository_get_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<User>> add(User entity) async {
    try {
      if (UserRepository.users == null) UserRepository.users = [];
      entity.id = (UserRepository.users.length > 0)
          ? UserRepository.users.last.id + 1
          : 1;
      UserRepository.users.add(entity);
      return new GatewayResponse<User>.goodResult(entity);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<User>.badResult(
        new InfraError('UserRepository_add_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<User>> update(User entity, int id) async {
    try {
      User result = _getUser(id);
      result.firstname = entity.firstname;
      result.lastname = entity.lastname;
      return new GatewayResponse<User>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<User>.badResult(
          new InfraError('UserRepository_update_error', e.toString()));
    }
  }

  Future<GatewayResponse<User>> delete(int id) async {
    try {
      User result = _getUser(id);
      UserRepository.users.remove(result);
      return new GatewayResponse<User>.goodResult(null);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<User>.badResult(
          new InfraError('UserRepository_delete_error', e.toString()));
    }
  }
}
