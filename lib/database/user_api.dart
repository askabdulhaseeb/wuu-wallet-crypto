import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';
import '../widget/custom_widgets/custom_toast.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<List<AppUser>> getAllUsers() async {
    final List<AppUser> appUser = <AppUser>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      appUser.add(AppUser.fromDoc(element));
    }
    return appUser;
  }

  // functions
  Future<AppUser?>? getInfo({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    if (doc.data() == null) return null;
    return AppUser.fromDoc(doc);
  }

  Future<bool> addUser(AppUser appUser) async {
    try {
      await _instance
          .collection(_collection)
          .doc(appUser.uid)
          .set(appUser.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}
