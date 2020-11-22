import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseService {
  FirebaseDatabaseService({this.uid});

  final String uid;
  final brewsCollection = Firestore.instance.collection('brews');

  Future<void> updateUserBrewData(
    String sugars,
    String name,
    int strength,
  ) async {
    await brewsCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Stream<QuerySnapshot> get brews {
    return brewsCollection.snapshots();
  }
}
