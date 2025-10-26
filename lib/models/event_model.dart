class Event {
  String title;
  String category;
  String date;
  String time;
  String description;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'date': date,
        'time': time,
        'description': description,
      };

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        title: json['title'],
        category: json['category'],
        date: json['date'],
        time: json['time'],
        description: json['description'],
      );
}
