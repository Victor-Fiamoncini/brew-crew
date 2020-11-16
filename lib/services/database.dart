import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  DatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _createBrewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((DocumentSnapshot brew) => Brew(
              name: brew.data['name'] ?? '',
              sugars: brew.data['sugars'] ?? '',
              strength: brew.data['strength'] ?? 0,
            ))
        .toList();
  }

  UserData _createUserdataFromSnapshot(DocumentSnapshot snapshot) => UserData(
        uid: uid,
        name: snapshot.data['name'] ?? '',
        sugars: snapshot.data['sugars'] ?? '',
        strength: snapshot.data['strength'] ?? 0,
      );

  Stream<List<Brew>> get brews => brewCollection
      .snapshots()
      .map((QuerySnapshot snapshot) => _createBrewListFromSnapshot(snapshot));

  Stream<UserData> get userData => brewCollection.document(uid).snapshots().map(
      (DocumentSnapshot snapshot) => _createUserdataFromSnapshot(snapshot));
}
