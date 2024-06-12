import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AddDeviceWidget extends StatefulWidget {
  @override
  _AddDeviceWidgetState createState() => _AddDeviceWidgetState();
}

class _AddDeviceWidgetState extends State<AddDeviceWidget> {
  String? selectedDevice;

  final List<String> devices = [
    'Akıllı Işık',
    'Akıllı Termostat',
    'Güvenlik Kamerası',
    'Akıllı Priz',
  ];

  void _showDeviceMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color(0xFF282636),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: devices.map((device) {
              return ListTile(
                title: Text(
                  device,
                  style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                ),
                onTap: () {
                  setState(() {
                    selectedDevice = device;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Merhaba Samet Soysal 👋",
                style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Evine Hoş Geldin.",
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          CupertinoButton(
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(15),
              padding: const EdgeInsets.only(left: 20, right: 20),
              minSize: 50,
              color: const Color(0xFF282636),
              child: Row(
                children: [
                  Text(
                    "Cihaz Ekle",
                    style: GoogleFonts.rubik(fontSize: 20, color: Colors.grey),
                  ),
                  const Icon(
                    Iconsax.add_circle,
                    color: Colors.grey,
                    size: 25,
                  )
                ],
              ),
              onPressed: () => _showDeviceMenu(context)),
        ],
      ),
    );
  }
}
