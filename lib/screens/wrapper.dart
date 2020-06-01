import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'package:machine_test_ex/models/user.dart';
import 'profile/profile_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    ScreenUtil.init(context, width: 393, height: 873, allowFontScaling: false);

    
    if(user ==  null){
      return Authenticate();
    }
    else{
      return ProfilePage();
    }
    
  }
}