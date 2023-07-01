

import 'package:firedart/firedart.dart';

import '../../custom/data/auth_service.dart';
import 'database_service.dart';
import 'serializable.dart';

class FirebaseDatabaseService<T extends Serializable> implements DatabaseService<T>
{
  FirebaseDatabaseService(this.collectionName, this.deserializeDocument);
  final String collectionName;
  final T Function(Map<String, dynamic>) deserializeDocument;

  CollectionReference get collection => Firestore.instance.collection(collectionName);

  T _documentToObject(Document d) {
    return deserializeDocument(d.map..addAll({'id' : d.id}));
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
  Future<List<T>> fetchByIds(List<String> ids) {
    return Future.wait(ids.map((id) => fetchById(id)));
  }
  
  @override
  Future<bool> add(T item) async {
    await collection.add(item.serialized());
    return true;
  }
  
  @override
  Future<List<T>> fetchWhere(String field, String value) async {
    final docs = await collection.where(field, isEqualTo: value).get();
    return docs.map<T>(_documentToObject).toList();
  }
  
  @override
  Future<Map<String, List<T>>> fetchWhereMultiple(String field, List<String> values) async {
    
    final lists = await Future.wait(values.map((value) => fetchWhere(field, value).then((results) => MapEntry(value, results))));
    return Map.fromEntries(lists);
  }
  
  @override
  Stream<T> streamById(String id) {
    return collection.document(id).stream.map((doc) => _documentToObject(doc!));
  }

}

class FirebaseAuthService implements AuthService {

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try
    {
      final firebaseUser = await FirebaseAuth.instance.signIn(email, password);
    }catch(e){}

    return true;

  }

}

class FirebaseLiteDatabaseService<T extends Serializable> extends FirebaseDatabaseService<T> {
  FirebaseLiteDatabaseService(super.collectionName, super.deserializeDocument);
  
  @override
  Future<List<T>> fetchAll() async {
    final docs = await collection.limit(10).get();
    return docs.map<T>(super._documentToObject).toList();
  }
}