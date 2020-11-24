import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:brew_crew/models/brew.dart';

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

  List<Brew> _serializeBrewsFromQuerySnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((brew) {
      return Brew(
        name: brew.data['name'] as String ?? '',
        sugars: brew.data['sugars'] as String ?? '',
        strength: brew.data['strength'] as int ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewsCollection.snapshots().map(_serializeBrewsFromQuerySnapshot);
  }

  Brew _serializeBrewFromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Brew(
      uid: uid,
      name: documentSnapshot.data['name'] as String ?? '',
      sugars: documentSnapshot.data['sugars'] as String ?? '',
      strength: documentSnapshot.data['strength'] as int ?? 0,
    );
  }

  Stream<Brew> get brew {
    return brewsCollection
        .document(uid)
        .snapshots()
        .map(_serializeBrewFromDocumentSnapshot);
  }
}
