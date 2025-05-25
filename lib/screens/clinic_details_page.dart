import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ClinicDetailsPage extends StatefulWidget {
  const ClinicDetailsPage({super.key}); // Added super.key

  @override
  _ClinicDetailsPageState createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  // Çalışma günleri ve hizmetler
  List<String> workingDays = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"];
  List<String> veterinaryServices = [
    'Muayene', 'Aşı', 'Ameliyat', 'Laboratuvar', 'Diş Tedavisi', 'Deri Hastalıkları',
    'Daha Fazla Aşı', 'Kan Alma ve Testler', 'Evrensel Aşılar', 'Aciliyet Müdahaleleri',
    'Röntgen ve Ultrason', 'Veteriner Fizik Tedavi', 'İç Parazit Tedavisi',
    'Dış Parazit Tedavisi', 'Sterilizasyon ve Kısırlaştırma'
  ];

  Map<String, bool> selectedDays = {};
  Map<String, bool> selectedServices = {};
  String? selectedStartTime;
  String? selectedEndTime;
  String? imagePath; // This was XFile? _image before, now String? imagePath

  @override
  void initState() {
    super.initState();
    for (var day in workingDays) { // Corrected forEach syntax
      selectedDays[day] = false;
    }
    for (var service in veterinaryServices) { // Corrected forEach syntax
      selectedServices[service] = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72.0), // Orijinalde 72.0 idi, kalsın
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Added const
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
                      backgroundColor: Colors.grey[300],
                      child: imagePath == null
                          ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[700])
                          : null,
                    ),
                    TextButton(
                      onPressed: pickImage,
                      child: const Text('Profil Resmi Yükle'), // Added const
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Added const
              Column( // Orijinalde bu Column yoktu ama Text'ler ve diğerleri alt alta olduğu için mantıklı
                children: [
                  const Text( // Added const
                    'Çalışma Saatleri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedStartTime = picked.format(context);
                              });
                            }
                          },
                          child: Text(selectedStartTime ?? 'Başlangıç Saati'),
                        ),
                      ),
                      const Text(" - "), // Added const
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedEndTime = picked.format(context);
                              });
                            }
                          },
                          child: Text(selectedEndTime ?? 'Bitiş Saati'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Added const
                  const Text( // Added const
                    'Çalışma Günleri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: workingDays.map((day) {
                      return FilterChip(
                        label: Text(day),
                        selected: selectedDays[day] ?? false,
                        onSelected: (bool value) {
                          setState(() {
                            selectedDays[day] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10), // Added const
                  const Text( // Added const
                    'Verdikleri Hizmetler',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: veterinaryServices.map((service) {
                      return FilterChip(
                        label: Text(service),
                        selected: selectedServices[service] ?? false,
                        onSelected: (bool value) {
                          setState(() {
                            selectedServices[service] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10), // Added const
                  const Text( // Added const
                    'Adresi Girin',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const TextField( // Added const, assuming no controller for now
                    decoration: InputDecoration(
                      labelText: 'Adres (İl, İlçe, Sokak vs.)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10), // Added const
                  const TextField( // Added const, assuming no controller for now
                    decoration: InputDecoration(
                      labelText: 'Web Sitesi (Opsiyonel)',
                      hintText: 'Örnek: www.klinik.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10), // Added const
                  const TextField( // Added const, assuming no controller for now
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      hintText: 'Klinik hakkında kısa bir açıklama',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20), // Added const
                  ElevatedButton(
                    onPressed: () {
                      // Kaydetme işlemi yapılabilir
                    },
                    style: ElevatedButton.styleFrom( // Moved style before child
                      backgroundColor: const Color.fromARGB(255, 235, 146, 176),
                      padding: const EdgeInsets.symmetric(vertical: 15), // Added const
                      minimumSize: const Size(double.infinity, 50), // Added const
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text( // Added const
                      'Kaydet',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
