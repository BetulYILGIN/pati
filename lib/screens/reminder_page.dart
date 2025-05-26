import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final Map<String, DateTime> selectedReminders = {};

  // Yeni hatırlatmalar listesi
  final List<String> staticReminders = [
    'Aşı Hatırlatması',
    'Veteriner Randevusu',
    'İlaç Hatırlatması',
    'Kum Temizleme',
    'Yürüyüşe Çıkarma',
  ];

  final List<String> feedingOptions = ['Su', 'Mama', 'Ödül', 'Vitamin'];

  // Tarih ve saat seçme fonksiyonu
  Future<void> _pickDateTime(String reminderKey) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final selected = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      selectedReminders[reminderKey] = selected;
    });
  }

  // Diğer için özel başlık alma
  void _addCustomReminder() async {
    String? customTitle = await showDialog<String>(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text("Hatırlatma Başlığı"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Örn: Tırnak kesimi"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );

    if (customTitle != null && customTitle.isNotEmpty) {
      _pickDateTime(customTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatırlatma Ekle'),
        backgroundColor: Colors.pink[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Üst görsel
            Image.asset(
              'assets/images/sayfa1.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),

            const SizedBox(height: 20),

            // Ana hatırlatmalar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Besleme Hatırlatması alt başlıkları
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Besleme Hatırlatması',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: feedingOptions.map((option) {
                      return ElevatedButton(
                        onPressed: () => _pickDateTime('Besleme: $option'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Diğer hatırlatma butonları
                  ...staticReminders.map((title) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.alarm),
                            label: Text(
                              title,
                              style: const TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _pickDateTime(title),
                          ),
                        ),
                      )),

                  // Diğer hatırlatma başlığı girme
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Diğer',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _addCustomReminder,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Kaydedilen hatırlatmalar
            if (selectedReminders.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kaydedilen Hatırlatmalar:',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...selectedReminders.entries.map((entry) {
                      final formattedDate =
                          '${entry.value.day.toString().padLeft(2, '0')}/${entry.value.month.toString().padLeft(2, '0')}/${entry.value.year}';
                      final formattedTime =
                          '${entry.value.hour.toString().padLeft(2, '0')}:${entry.value.minute.toString().padLeft(2, '0')}';

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.notifications),
                          title: Text(entry.key),
                          subtitle: Text('$formattedDate - $formattedTime'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                selectedReminders.remove(entry.key);
                              });
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
