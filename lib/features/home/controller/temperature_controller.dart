import 'dart:async';
import 'dart:math';
import 'package:smart_home/features/home/model/temperature_model.dart';

class TemperatureController {
  final List<TemperatureData> _temperatureData = [];
  final _random = Random();
  Timer? _timer;

  List<TemperatureData> get temperatureData => _temperatureData;

  void startGeneratingData() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // 5 saniyeden 2 saniyeye değiştirildi
      final newTemperature = TemperatureData(
        DateTime.now(),
        15 + _random.nextDouble() * 10, // 15-25 derece arası rastgele sıcaklık
      );
      _temperatureData.insert(0, newTemperature); // Yeni veri başa ekleniyor
    });
  }

  void stopGeneratingData() {
    _timer?.cancel();
  }
}
