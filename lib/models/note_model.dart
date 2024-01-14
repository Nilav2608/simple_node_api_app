class NoteModel {
  String? id;
  String? title;
  String? description;
  bool? completed;
  String? date;

  NoteModel({this.id, this.title, this.description, this.completed, this.date});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    date = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['completed'] = completed;
    data['createdAt'] = date;
    return data;
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    String? date,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      date: date ?? this.date,
    );
  }
}
