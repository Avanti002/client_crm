import 'package:quantbit_crm/face_detection/face_detection_services/camera_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/ml_service.dart';
import 'package:quantbit_crm/face_detection/face_detection_services/face_detector_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  locator.registerLazySingleton<MLService>(() => MLService());
}
