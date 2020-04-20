import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
	final String uid;
	final CollectionReference brewCollection = Firestore.instance.collection('brews');

	DatabaseService({ this.uid });

	Future updateUserData(String sugars, String name, int strength) async {
		return await brewCollection.document(uid).setData({
			'sugars': sugars,
			'name': name,
			'strength': strength,
		});
	}

	List<Brew> _createBrewListFromSnapshot(QuerySnapshot snapshot) {
		return snapshot.documents.map((DocumentSnapshot brew) => Brew(
			name: brew.data['name'] ?? '',
			sugars: brew.data['sugars'] ?? '',
			strength: brew.data['strength'] ?? 0,
		)).toList();
	}

	Stream<List<Brew>> get brews => brewCollection
		.snapshots()
		.map((QuerySnapshot snapshot) => _createBrewListFromSnapshot(snapshot));
}
