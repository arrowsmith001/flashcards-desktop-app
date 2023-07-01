
abstract class Serializable {
  Serializable(this.id);

  final String? id;
  Map<String, dynamic> serialized();
}