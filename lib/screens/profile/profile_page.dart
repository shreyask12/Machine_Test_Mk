import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:machine_test_ex/screens/profile/edit_profile.dart';
import 'package:machine_test_ex/services/auth_service.dart';
import 'package:machine_test_ex/services/database_service.dart';
import 'package:machine_test_ex/models/userdetails.dart';
// import 'package:machine_test_ex/shared/loader.dart';
import 'package:provider/provider.dart';
import 'package:machine_test_ex/screens/profile/user_profile.dart';

class ProfilePage extends StatelessWidget {


  final FireBaseAuthService auth = FireBaseAuthService();

  @override
  Widget build(BuildContext context) {

    // final user = Provider.of<User>(context,listen:false);
    // print(user.uid);

    // ScreenUtil.init(context, width: 393, height: 873, allowFontScaling: false);


   void _showSettingsPanel() async{
    //  final user = Provider.of<FireBaseAuthService>(context,listen: false);
    //  final currentuser = await user.currentUser();
    // //  print(currentuser.uid);
      showModalBottomSheet(context: context, 
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical:ScreenUtil().setWidth(20),horizontal: ScreenUtil().setWidth(60)),
          child: EditForm(),
        );
      },
      isScrollControlled: true,
      );
    }

    

    return StreamProvider<List<UserDetails>>.value(
      value: DatabaseService().userdetails,
        // if(snapshot.hasData){
          child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              title:Text('HomePage',style: TextStyle(color: Colors.white,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold,
              )),
              backgroundColor: Color(0xff00a79b),
              elevation: 0.0,
              actions: <Widget>[  
                FlatButton.icon(
                  icon: Icon(Icons.edit,color: Colors.white,), 
                  label: Text('Edit',style: TextStyle(color: Colors.white)),
                onPressed: () => _showSettingsPanel(),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.person,color: Colors.white,), 
                  label: Text('Logout',style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final auth = Provider.of<FireBaseAuthService>(context,listen: false);
                    await auth.signOut();
                    // Navigator.pop(context);
                  }, 
                ),
              ],
            ),
            body: UserProfile(
          ),
        ),
      );
  }
}