import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final CollectionReference dbrefuser =
      FirebaseFirestore.instance.collection('Users');

  var _user = RxMap<String, dynamic>();
  var _LoadingUserData = true.obs;
  var _userid;

 UserController(String userid) {
  _userid = userid;
  _LoadingUserData.value = true; 
  initializeuser(userid).then((_) {
    _LoadingUserData.value = false;
  });
}

  Future<void> initializeuser(String userid) async {
    _user = await userData(userid);
  }

  Future<RxMap<String, dynamic>> userData(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbrefuser.doc(docid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        RxMap<String, dynamic> userdata = RxMap<String, dynamic>.from(userData);
        return userdata;
      } else {
        return RxMap<String,
            dynamic>(); // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return RxMap<String, dynamic>(); // Return empty map if there's an error
    }
  }

  get loading => _LoadingUserData;
  get userid => _userid;
  get userdata => _user;
}