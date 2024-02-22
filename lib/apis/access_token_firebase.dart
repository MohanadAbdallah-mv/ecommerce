import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
class AccessTokenFirebase{
  static String firebaseMessagingScope= "https://www.googleapis.com/auth/firebase.messaging" ;
  Future<String> getAccessToken()async{
    final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(
          {"inset your firebase admin key pair here"
          },
    ),[firebaseMessagingScope]
    );
    final accessToken = client.credentials.accessToken.data;
    print("access token is $accessToken");
    return accessToken;
  }

}