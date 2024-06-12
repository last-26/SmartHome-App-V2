import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_home/features/datails/widgets/animation.dart';
import 'package:smart_home/features/home/controller/controller.dart';
import 'package:smart_home/features/home/widgets/add_device.dart';
import 'package:smart_home/features/home/widgets/custom_card.dart';
import 'package:smart_home/features/home/widgets/electricity_card.dart';
import 'package:smart_home/features/home/widgets/scale_fadeanimation.dart';
import 'package:smart_home/features/home/widgets/master_painter.dart';
import 'widgets/topbar.dart';
import 'package:smart_home/router/router.dart';
import 'package:smart_home/features/home/controller/temperature_controller.dart';
import 'package:smart_home/features/home/model/temperature_model.dart';
import 'package:smart_home/features/home/temperature_screen.dart';
import 'package:smart_home/database_helper.dart'; // Yeni dosyayı import edin

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  var model_list = Controller().model_list;
  double temperature = 0.0;
  double sound = 0.0;
  double brightness = 0.0;
  int userCount = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromFile(); // Uygulama başlatıldığında veri dosyasından verileri yükler
  }

  Future<void> _loadDataFromFile() async {
    final dbHelper = DatabaseHelper.instance;

    // JSON dosyasını oku
    String dataString = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> dataJson = json.decode(dataString);

    // Veritabanını temizle ve yeni verileri ekle
    await dbHelper.clearTable(); // Tabloyu temizler
    await dbHelper.insert({
      'temperature': dataJson['sensor_data']['temperature'],
      'sound': dataJson['sensor_data']['sound'],
      'brightness': dataJson['sensor_data']['brightness'],
      'user_count': dataJson['sensor_data']['user_count'],
    });

    // Verileri güncelle
    _fetchData();
  }

  void _fetchData() async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> latestData = await dbHelper.queryLatest();

    if (latestData.isNotEmpty) {
      setState(() {
        temperature = latestData['temperature'] ?? 0.0;
        sound = latestData['sound'] ?? 0.0;
        brightness = latestData['brightness'] ?? 0.0;
        userCount = latestData['user_count'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1D30),
      body: CustomPaint(
        painter: MasterPainter(),
        child: BounceFromBottomAnimation(
          delay: 10,
          child: Column(
            children: [
              const SizedBox(height: 60),
              BounceFromBottomAnimation(delay: 6, child: topbar()),
              BounceFromBottomAnimation(
                  delay: 6,
                  child: AddDeviceWidget()), // Use AddDeviceWidget here
              const SizedBox(height: 20),
              BounceFromBottomAnimation(
                  delay: 4, child: electricitycard(context)),
              const SizedBox(height: 10),
              BounceFromBottomAnimation(
                delay: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      CupertinoButton(
                        alignment: Alignment.center,
                        borderRadius: BorderRadius.circular(15),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        minSize: 20,
                        child: Row(
                          children: [
                            Text(
                              "",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const Icon(
                              Iconsax.arrow_right_1,
                              color: Colors.grey,
                              size: 18,
                            )
                          ],
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 420,
                width: 420,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Controller().model_list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var data = Controller().model_list[index];
                    return ScaleFadeAnimation(
                      delay: 2.5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              Routes.detailsscreen.path,
                              extra: data.model,
                            );
                          },
                          child: CustomCardView(model: data),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _loadDataFromFile, // Veri dosyasından güncelleme
                child: Text('Verileri Güncelle'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TemperatureScreen()),
                  );
                },
                child: Text('Sıcaklık Verilerini Görüntüle'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text('Sıcaklık: $temperature °C',
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Colors.white)),
                    Text('Ses: $sound dB',
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Colors.white)),
                    Text('Parlaklık: $brightness %',
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Colors.white)),
                    Text('Kullanıcı Sayısı: $userCount',
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
