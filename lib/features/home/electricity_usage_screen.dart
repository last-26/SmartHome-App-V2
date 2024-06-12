import 'package:flutter/material.dart';

class ElectricityUsageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elektrik Kullanımı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detaylı Elektrik Kullanımı',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Örnek olarak statik veri ekliyoruz. Buraya dinamik veriler de ekleyebilirsiniz.
            Text(
              'Bu Ay: 63.2 kWh',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Son Ay: 58.4 kWh',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Ortalama Kullanım: 60.5 kWh',
              style: TextStyle(fontSize: 18),
            ),
            // Daha fazla detay ekleyebilirsiniz.
          ],
        ),
      ),
    );
  }
}
