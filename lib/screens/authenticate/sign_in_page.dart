import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_ex/screens/profile/profile_page.dart';
import 'package:machine_test_ex/services/auth_service.dart';
import 'package:machine_test_ex/shared/loader.dart';
import 'package:machine_test_ex/widgets/custom_button.dart';
import 'sign_up_page.dart';
import 'package:provider/provider.dart';
import 'package:machine_test_ex/exceptions/validators.dart';

import 'package:machine_test_ex/exceptions/platform_exception.dart';

class SignInPage extends StatefulWidget with EmailAndPasswordProviders{


  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _loginscaffoldkey = GlobalKey<ScaffoldState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

   bool emailValid = true;

    bool passwordValid =true;

  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async{
    // setState(() {
    //   _submitted = true;
    //   
    // });
    var dontproceed = true;

    if(_email == '' || _email == null ){
      setState(() {
        emailValid = false;
      });
      
      dontproceed =false;

    }
    if( _password == '' || _password == null ){
       setState(() {
        passwordValid = false;
      });
     dontproceed =false;
    }
    if(dontproceed){

      try{
        setState(() {
          _isLoading = true;
        });
        final auth = Provider.of<FireBaseAuthService>(context,listen: false);
       final user =  await auth.signInWithEmailAndPassword(_email, _password);

        if(user != null){

           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
              return ProfilePage();
              }),
            ); 
                                     
        }else{
          _isLoading = false;
        }
      
      Navigator.of(context).pop();
      }on PlatformException catch(e){
        PlatFormExceptionAlertDialog(
        exception: e,  
        title: 'Sign in failed',
        ).show(context);
        print(e);
        // _isLoading = false;
      }finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return _isLoading ? Loading() : Scaffold(
        key: _loginscaffoldkey,
        backgroundColor: Color(0xfffffff),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(480),
                width: ScreenUtil().setWidth(393),
                decoration: BoxDecoration(
                  color: Color(0xff042c38),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/MaskGroup1.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
          
              ),
              Positioned(
                bottom: ScreenUtil().setWidth(0.0),
                child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:ScreenUtil().setWidth(20.0),left:ScreenUtil().setWidth(30.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Divider(color: Colors.white,thickness: 10.0,height: 10.0,),
                        Text('Log In!',
                        style: TextStyle(color:Colors.white,
                          fontSize: ScreenUtil().setSp(20),
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(393),
                    height: ScreenUtil().setWidth(390),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
            
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:ScreenUtil().setWidth(30.0),right:ScreenUtil().setWidth(30.0),top:ScreenUtil().setWidth(20.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // Icon(Icons.group),
                              Image.asset('assets/images/Icon-feather-mail.png'),
                              Padding(
                                padding: EdgeInsets.only(left:ScreenUtil().setWidth(42.0)),
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(230),
                                  child: TextField(
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(30),
                                    ],
                                    onChanged: (val){
                                      if(val != ''){
                                        setState(() {
                                          emailValid = true;
                                        });
                                      }
                                    },
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    // maxLength: 10,
                                    decoration: InputDecoration(
                                    hintText: 'Email',
                                    errorText: emailValid ? null :  widget.emailerror,
                                      hintStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // Icon(Icons.lock),
                              Image.asset('assets/images/Icon-feather-lock.png'),
                              Padding(
                                padding: EdgeInsets.only(left:ScreenUtil().setWidth(42.0)),
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(230),
                                  child: TextField(
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    onChanged: (val){
                                    if(val != ''){
                                        setState(() {
                                          passwordValid = true;
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: _passwordController,
                                    obscureText: true,
                                    // maxLength: 10,
                                    decoration: InputDecoration(
                                    errorText: passwordValid ? null : widget.passwordError,
                                    hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          FormSubmitButton( buttonType: 'SIGN IN',onPressed: _submit,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Dont have an account?',
                               style: TextStyle(color:Color(0xffa6a6a6),
                                  fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
                                   return Signup();
                                   }),
                                   );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(10)),
                                  child: Text('SIGN UP',style: TextStyle(color:Color(0xff00a79b),
                                    fontSize: ScreenUtil().setSp(17.0,allowFontScalingSelf: true),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ],
            ),
          ),
        ),
    );
  }

}

