class Classwork{
  int? id;
  String? name;

  bool? completed;
  
  Classwork({this.id, this.name,  this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
     
      'completed': completed,
    };
  }
}