import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Map<String, bool> favourites = {};

addUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    firestore.collection('users').doc(user.uid).set({"email": user.email});
  }
}

addItemToFavourites(Map<String, String> map, String uid) {
  firestore
      .collection('users')
      .doc(uid)
      .collection('favourites')
      .doc(map["barcode"])
      .set(map);
}

removeItemFromFavourites(String barcode, String uid) {
  firestore
      .collection('users')
      .doc(uid)
      .collection('favourites')
      .doc(barcode)
      .delete();
}

getItemByBarcode(String barcode) {}

// Future<Map<String, String>> getAllFavouritesNamesFromUser(String uid) async{
//   Map<String, String> map = <String, String>{};
//   var data = await firestore
//       .collection('users')
//       .doc(uid)
//       .collection('favourites')
//       .get();
//   var dataDocs = data.docs;
//   for(int i=0; i< dataDocs.length;i++){
//         map[dataDocs[i]["barcode"]] = dataDocs[i]["productName"];
//   }

//   return map;
// }
