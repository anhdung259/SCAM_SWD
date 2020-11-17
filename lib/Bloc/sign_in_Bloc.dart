import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:swd_project/Bloc/get_Product_Bloc.dart';
import 'TaskMenu/User_Bloc.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn ggSign = GoogleSignIn();
final LocalStorage localStore = new LocalStorage('user');
final LocalStorage localStoreToken = new LocalStorage('token');

bool checkLogin() {
  if (auth.currentUser != null) {
    return true;
  } else {
    return false;
  }
}

Future<String> signInWithGG() async {
  Firebase.initializeApp();
  GoogleSignInAccount googleSignInAccount = await ggSign.signIn();

  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  UserCredential authResult = await auth.signInWithCredential(credential);

  User user = authResult.user;

  assert(!user.isAnonymous);
  Future<String> getId() async {
    final String id = await authResult.user.getIdToken();
    return id;
  }

  assert(await user.getIdToken() != null);
  await getId().then((token) async {
    await userBloc.getUserLogin(token);
  });
  await productBloc.getProductRecommend();
  return "$user";
}

void signOutGG() async {
  await ggSign.signOut();
  await auth.signOut();
  await localStoreToken.clear();
  await localStore.clear();
  await productBloc.reset();
}
