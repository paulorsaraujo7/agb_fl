import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class Lanterna with ChangeNotifier {
  bool _isFlashModeOn = false;
  CameraController? _cameraController;
  List<CameraDescription>? _listOfCameras;

  bool get isFlashModeOn {
    return _isFlashModeOn;
  }

  Future<void> liberarCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
  }

  Future<void> initializeCamera() async {
    _listOfCameras = await availableCameras(); //Existe câmera disponível?
    if (_cameraController == null) {
      try {
        _cameraController = CameraController(
            _listOfCameras![0], ResolutionPreset.low,
            imageFormatGroup: ImageFormatGroup.yuv420,
            enableAudio: false,); //evita solicitar pemissão para o audio se não vai usar
      } on CameraException catch (e) {
        //print(e);
      }
    }
  }

  Future<void> toggleFlashMode() async {
    if (_cameraController != null) {
      try {
        _isFlashModeOn = !_isFlashModeOn; //alterna entre o estado anterior
        notifyListeners();
        // 3 - Tenta inicializar a câmera
        _cameraController!.initialize().then((_) {
          if (isFlashModeOn){
            _cameraController!.setFlashMode(FlashMode.torch);
          }
          else
            _cameraController!.setFlashMode(FlashMode.off);
        });
      } on CameraException catch (e) {
        //print(e);
      }
    }
  }
}