import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

//-=-=-=-=-=-=-=-=-=-=-=-Saving Collection-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "weight": [],
      "date": "",
      "uid": uid,
    });
  }

//-=-=-=-=-=-=-=-=-=-=-=-Getting user data-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future addWeight(double weight, DateTime date) {
    return userCollection.doc(uid).update({
      "weight": FieldValue.arrayUnion(["${weight}_$date"])
    });
  }

//-=-=-=-=-=-=-=-=-=-=-=-Getting weights-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  getUserWeights() async {
    return userCollection.doc(uid).snapshots();
  }

  deleteWeight(weight) {
    userCollection.doc(uid).update({'weight': FieldValue.arrayRemove(weight)});
  }
}
