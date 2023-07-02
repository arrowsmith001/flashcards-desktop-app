

abstract class Entity {
  Entity(this.id);

  String? id;
  Map<String, dynamic> serialized();
  bool isEqualTo(Entity other){
    return id == other.id;
  } 
}