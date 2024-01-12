class NoteModel {
  String? id;
  String? title;
  String? description;
  bool? completed;
  String? date;

  NoteModel({this.id, this.title, this.description, this.completed, this.date});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['completed'] = completed;
    data['date'] = date;
    return data;
  }
}
