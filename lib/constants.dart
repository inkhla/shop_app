import 'package:shop_app/shared/components/components.dart';

import 'modules/shop_app/login/shop_login_screen.dart';
import 'shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}


///this function prints the whole text without cutting it

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
String uId = '';