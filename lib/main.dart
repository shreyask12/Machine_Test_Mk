import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_test_ex/services/auth_service.dart';
import 'screens/wrapper.dart';
import 'package:machine_test_ex/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:machine_test_ex/models/userdetails.dart';
import 'package:machine_test_ex/models/user.dart';


  void main() async { 
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_){
    runApp(MyApp());
    });
  }
// });


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     MultiProvider(
          providers: [
            
            Provider<FireBaseAuthService>(
              create: (_) => FireBaseAuthService(),
            ),
            Provider<User>(
              create: (_) => User(),
            ),
            Provider<UserDetails>(
              create: (_) => UserDetails(),
            ),
            Provider<DatabaseService>(
              create: (_) => DatabaseService()),
          ],
    child:  StreamProvider<User>.value(
        value: FireBaseAuthService().user,
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // hintColor: Color(0xFFC0F0E8),
            primaryColor:  Color(0xff00a79b),
            focusColor:  Color(0xff00a79b),
            // canvasColor: Colors.transparent),
          ),
            // fontFamily: "Montserrat",
          home: Wrapper(),
        ),
        ),
     );

    
  }
}