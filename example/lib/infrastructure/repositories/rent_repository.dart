import 'package:example/infrastructure/entities/rents.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class RentRepository {
  static List<Rent> rents = [];

  Rent _getRent(int userId, int videoId) {
    Rent result;
    for (int i = 0; i <= RentRepository.rents.length; i++) {
      if (RentRepository.rents[i].userId == userId &&
          RentRepository.rents[i].videoId == videoId) {
        result = RentRepository.rents[i];
        break;
      }
    }
    if (result == null)
      throw new Exception(
          'unable to get rent with userId $userId and videoId $videoId.');
    return result;
  }

  Future<GatewayResponse<Rent>> getById(int userId, int videoId) async {
    try {
      Rent result = _getRent(userId, videoId);
      return new GatewayResponse<Rent>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Rent>.badResult(
        new InfraError('RentRepository_getById_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<List<Rent>>> get() async {
    try {
      if (RentRepository.rents == null)
        throw new Exception('unable to get rents.');
      return new GatewayResponse<List<Rent>>.goodResult(RentRepository.rents);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<List<Rent>>.badResult(
        new InfraError('RentRepository_get_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<Rent>> add(Rent entity) async {
    try {
      if (RentRepository.rents == null) RentRepository.rents = [];
      RentRepository.rents.add(entity);
      return new GatewayResponse<Rent>.goodResult(entity);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Rent>.badResult(
        new InfraError('RentRepository_add_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<Rent>> update(
      Rent entity, int userId, int videoId) async {
    try {
      Rent result = _getRent(userId, videoId);
      result.rentDate = entity.rentDate;
      return new GatewayResponse<Rent>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Rent>.badResult(
          new InfraError('RentRepository_update_error', e.toString()));
    }
  }

  Future<GatewayResponse<Rent>> delete(int userId, int videoId) async {
    try {
      Rent result = _getRent(userId, videoId);
      RentRepository.rents.remove(result);
      return new GatewayResponse<Rent>.goodResult(null);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Rent>.badResult(
          new InfraError('RentRepository_delete_error', e.toString()));
    }
  }
}
