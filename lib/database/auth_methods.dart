import 'package:firebase_auth/firebase_auth.dart';
import '../backend/erc_20_wallet.dart';
import '../backend/wallet_addresses.dart';
import '../functions/time_date_functions.dart';
import '../helpers/app_config.dart';
import '../models/app_user.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'user_api.dart';
import 'user_local_data.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;

  static String get uid => _auth.currentUser?.uid ?? '';
  final ERC20WalletAd _erc20walletAd = ERC20WalletAd();
  final WalletAd _walletAd = WalletAd();

  static String get uniqueID => uid + TimeDateFunctions.timestamp.toString();

  Future<User?> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      await UserAPI().addUser(
        AppUser(
          uid: user!.uid,
          name: '',
          email: email,
          username: '',
          imageURL: '',
        ),
      );
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      final AppUser? appUser = await UserAPI().getInfo(uid: user!.uid);
      UserLocalData().storeAppUserData(appUser: appUser!);
      walletAddMap = await _walletAd.createWallet();
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<void> signOut() async {
    UserLocalData.signout();
    await _auth.signOut();
  }
}
