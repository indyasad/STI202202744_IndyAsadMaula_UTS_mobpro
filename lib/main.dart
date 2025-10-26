import 'package:flutter/material.dart';
import 'pages/event_list_page.dart';
import 'pages/add_event_page.dart';
import 'pages/media_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Event Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Event Planner"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: "Daftar Event"),
              Tab(icon: Icon(Icons.add), text: "Tambah Event"),
              Tab(icon: Icon(Icons.video_library), text: "Media"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventListPage(),
            AddEventPage(),
            MediaPage(),
          ],
        ),
      ),
    );
  }
}
