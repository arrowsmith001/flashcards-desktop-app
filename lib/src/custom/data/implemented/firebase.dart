import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';

import '../abstract/auth_service.dart';
import '../abstract/database_service.dart';
import '../abstract/entity.dart';

class FirebaseDatabaseService<T extends Entity> implements DatabaseService<T> {
  FirebaseDatabaseService(this.collectionName, this.deserializeDocument);
  final String collectionName;
  final T Function(Map<String, dynamic>) deserializeDocument;

  CollectionReference get collection =>
      Firestore.instance.collection(collectionName);

  T _documentToObject(Document d) {
    return deserializeDocument(d.map..addAll({'id': d.id}));
  }

  @override
  Future<List<T>> fetchAll() async {
    final docs = await collection.get();
    return docs.map<T>(_documentToObject).toList();
  }

  @override
  Future<T> fetchById(String id) async {
    final doc = await collection.document(id).get();
    return _documentToObject(doc);
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) {
    return Future.wait(ids.map((id) => fetchById(id)));
  }

  @override
  Future<T> create(T item) async {
    final doc = await collection.add(item.serialized());
    return _documentToObject(doc);
  }

  @override
  Future<List<T>> fetchWhere(String field, String value) async {
    final docs = await collection.where(field, isEqualTo: value).get();
    return docs.map<T>(_documentToObject).toList();
  }

  @override
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values) async {
    final lists = await Future.wait(values.map((value) =>
        fetchWhere(field, value).then((results) => MapEntry(value, results))));
    return Map.fromEntries(lists);
  }

  @override
  Stream<T> streamById(String id) {
    return collection.document(id).stream.map((doc) => _documentToObject(doc!));
  }

  @override
  Future<void> setField(String itemId, String fieldName, dynamic value) {
    return collection.document(itemId).update({fieldName: value});
  }

  @override
  Future<void> delete(String itemId) {
    throw UnimplementedError();
  }
}

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    final firebaseUser = await auth.signIn(email, password);
  }

  @override
  Future<String?> getLoggedInId() async {
    return (await isLoggedIn()) ? auth.userId : null;
  }

  @override
  Future<bool> isLoggedIn() async => auth.isSignedIn;
}

class FirebaseLiteDatabaseService<T extends Entity>
    extends FirebaseDatabaseService<T> {
  FirebaseLiteDatabaseService(super.collectionName, super.deserializeDocument);

  @override
  Future<List<T>> fetchAll() async {
    final docs = await collection.limit(10).get();
    return docs.map<T>(super._documentToObject).toList();
  }
}
