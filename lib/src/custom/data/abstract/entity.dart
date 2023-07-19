abstract class Entity {
  Entity(this.id);

  String? id;

  Map<String, dynamic> serialized();


  Entity clone();

  // TODO: To avoid repetition, consider a DTO for immutable fields (or freezed)
  Entity cloneWithId(String newId);


  bool isEqualTo(Entity other) {
    return id == other.id;
  }
}
