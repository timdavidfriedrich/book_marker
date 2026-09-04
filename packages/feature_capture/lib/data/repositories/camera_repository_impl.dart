import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_capture/data/data_sources/camera_data_source.dart';
import 'package:feature_capture/data/data_sources/gallery_data_source.dart';
import 'package:feature_capture/data/mappers/camera_frame_mappers.dart';
import 'package:feature_capture/domain/repositories/camera_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/camera_frame.dart';

@Injectable(as: CameraRepository)
class const CameraRepositoryImpl(
  final CameraDataSource _cameraDataSource,
  final GalleryDataSource _galleryDataSource,
) implements CameraRepository {
  @override
  Future<AppResult<CameraController>> open(void Function(CameraFrame frame) onFrame) async {
    try {
      final camera = await _cameraDataSource.open(
        (image, rotationDegrees) => onFrame(image.toCameraFrame(rotationDegrees)),
      );
      if (camera == null) return const Failure(UnexpectedError());
      return Success(camera);
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> close(CameraController camera) async {
    try {
      await _cameraDataSource.close(camera);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setTorch(CameraController camera, {required bool isOn}) async {
    try {
      await _cameraDataSource.setTorch(camera, isOn: isOn);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<String>> takePicture(CameraController camera) async {
    try {
      return Success(await _cameraDataSource.takePicture(camera));
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<List<String>>> pickImages() async {
    try {
      return Success(await _galleryDataSource.pickImages());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
