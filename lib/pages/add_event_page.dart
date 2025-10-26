import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../utils/file_manager.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String category = 'Seminar';
  DateTime? date;
  TimeOfDay? time;

  List<String> categories = ['Seminar', 'Ulang Tahun', 'Kampus', 'Lainnya'];

  void saveEvent() async {
    if (titleController.text.isEmpty || date == null || time == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Isi semua data")));
      return;
    }
    List<Event> events = await FileManager.readEvents();
    events.add(Event(
      title: titleController.text,
      category: category,
      date: "${date!.day}-${date!.month}-${date!.year}",
      time: "${time!.hour}:${time!.minute}",
      description: descController.text,
    ));
    await FileManager.writeEvents(events);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Event tersimpan")));
    titleController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          TextField(controller: titleController, decoration: const InputDecoration(labelText: "Nama Event")),
          DropdownButtonFormField(
            initialValue: category,
            items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => category = v!),
            decoration: const InputDecoration(labelText: "Kategori"),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now(),
                    );
                    setState(() {});
                  },
                  child: Text(date == null ? "Pilih Tanggal" : "${date!.day}-${date!.month}-${date!.year}"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    setState(() {});
                  },
                  child: Text(time == null ? "Pilih Waktu" : "${time!.hour}:${time!.minute}"),
                ),
              ),
            ],
          ),
          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: "Deskripsi"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: saveEvent, child: const Text("SIMPAN")),
        ],
      ),
    );
  }
}
