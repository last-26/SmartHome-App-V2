import 'package:flutter/material.dart';
import 'package:smart_home/features/home/controller/temperature_controller.dart';

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final TemperatureController _temperatureController = TemperatureController();

  @override
  void initState() {
    super.initState();
    _temperatureController.startGeneratingData();
  }

  @override
  void dispose() {
    _temperatureController.stopGeneratingData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sıcaklık Verileri'),
      ),
      body: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Column(
            children: [
              if (_temperatureController.temperatureData.isNotEmpty) ...[
                if (_temperatureController.temperatureData.last.temperature < 16)
                  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Uyarı: Sıcaklık 16 °C\'nin altına düştü!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                if (_temperatureController.temperatureData.last.temperature > 24)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Uyarı: Sıcaklık 24 °C\'nin üstüne çıktı!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
              ],
              Expanded(
                child: ListView.builder(
                  itemCount: _temperatureController.temperatureData.length,
                  itemBuilder: (context, index) {
                    final data = _temperatureController.temperatureData[index];
                    return ListTile(
                      title: Text('${data.temperature.toStringAsFixed(2)} °C'),
                      subtitle: Text(data.time.toString()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
