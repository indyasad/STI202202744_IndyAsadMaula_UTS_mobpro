import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/event_card.dart';
import '../utils/file_manager.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    events = await FileManager.readEvents();
    setState(() {});
  }

  void deleteEvent(int index) async {
    bool confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Event"),
        content: const Text("Yakin ingin menghapus event ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );
    if (confirm) {
      events.removeAt(index);
      await FileManager.writeEvents(events);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Event dihapus")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(
          event: events[index],
          onTap: () {},
          onDelete: () => deleteEvent(index),
          onEdit: () {},
        );
      },
    );
  }
}
