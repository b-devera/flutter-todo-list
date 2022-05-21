///
/// Added by Atsuya
/// CMPE-137
/// 05/20/2022
///

class Task {
  int? id;
  String? title;
  DateTime? date;
  String? category;
  int? status;

  Task({this.title,this.date, this.category, this.status});

  Task.withId({this.id, this.title, this.date, this.category, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['date'] = date!.toIso8601String();
    map['category'] = category;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        category: map['category'],
        status: map['status']);
  }
}



