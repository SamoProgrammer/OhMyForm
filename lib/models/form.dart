class Form {
  int id;
  String title;
  DateTime endTime;
  // Add other properties as needed

  Form({required this.id, required this.title, required this.endTime});

  // Named constructor to create a Form object from JSON data
  Form.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        endTime = DateTime.parse(json['endTime']);

  // Method to convert a Form object to JSON data
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'endTime': endTime.toIso8601String(),
        // Add other properties as needed
      };
}
