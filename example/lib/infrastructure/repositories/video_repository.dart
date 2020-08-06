import 'package:example/infrastructure/entities/video.dart';
import 'package:flutter_hexagonal_architecture/flutter_hexagonal_architecture.dart';

class VideoRepository {
  static List<Video> videos = [];

  Video _getVideo(int id) {
    Video result;
    for (int i = 0; i <= VideoRepository.videos.length; i++) {
      if (VideoRepository.videos[i].id == id) {
        result = VideoRepository.videos[i];
        break;
      }
    }
    if (result == null)
      throw new Exception('unable to get video with videoId $id.');
    return result;
  }

  Future<GatewayResponse<Video>> getById(int id) async {
    try {
      Video result = _getVideo(id);
      return new GatewayResponse<Video>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Video>.badResult(
        new InfraError('VideoRepository_getById_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<List<Video>>> get() async {
    try {
      if (VideoRepository.videos == null)
        throw new Exception('unable to get videos.');
      return new GatewayResponse<List<Video>>.goodResult(
          VideoRepository.videos);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<List<Video>>.badResult(
        new InfraError('VideoRepository_get_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<Video>> add(Video entity) async {
    try {
      if (VideoRepository.videos == null) VideoRepository.videos = [];
      entity.id = (VideoRepository.videos.length > 0)
          ? VideoRepository.videos.last.id + 1
          : 1;
      VideoRepository.videos.add(entity);
      return new GatewayResponse<Video>.goodResult(entity);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Video>.badResult(
        new InfraError('VideoRepository_add_error', e.toString()),
      );
    }
  }

  Future<GatewayResponse<Video>> update(Video entity, int id) async {
    try {
      Video result = _getVideo(id);
      result.title = entity.title;
      return new GatewayResponse<Video>.goodResult(result);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Video>.badResult(
          new InfraError('VideoRepository_update_error', e.toString()));
    }
  }

  Future<GatewayResponse<Video>> delete(int id) async {
    try {
      Video result = _getVideo(id);
      VideoRepository.videos.remove(result);
      return new GatewayResponse<Video>.goodResult(null);
    } on Exception catch (e) {
      print(e);
      return new GatewayResponse<Video>.badResult(
          new InfraError('VideoRepository_delete_error', e.toString()));
    }
  }
}
