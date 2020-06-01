import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_ex/screens/profile/profile_page.dart';
import 'package:machine_test_ex/services/auth_service.dart';
import 'package:machine_test_ex/shared/loader.dart';
import 'package:machine_test_ex/widgets/custom_button.dart';
import 'package:machine_test_ex/services/database_service.dart';
import 'package:machine_test_ex/exceptions/platform_exception.dart';
import 'package:machine_test_ex/models/userdetails.dart';
import 'sign_in_page.dart';
import 'package:machine_test_ex/exceptions/validators.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget with EmailAndPasswordProviders{

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  // final _auth = FirebaseAuth.instance;

  final _signupScaffold = GlobalKey<ScaffoldState>();
  // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  // final GlobalKey<FormFieldState> _specifyTextFieldKey = GlobalKey<FormFieldState>();


  final TextEditingController firstnamecontrol = TextEditingController();
  final TextEditingController lastnamecontrol = TextEditingController();

  final TextEditingController emailcontrol = TextEditingController();
  final TextEditingController passwordcontrol = TextEditingController();
  final TextEditingController addressControl = TextEditingController();
  final TextEditingController ageControl = TextEditingController();
  final TextEditingController mobileControl = TextEditingController();

   String get _email => emailcontrol.text;
   String get _password => passwordcontrol.text;
   String get _firstname => firstnamecontrol.text;
   String get _lastname => lastnamecontrol.text;
   String get _address => addressControl.text;
   String get _age => ageControl.text;
   String get _mobileno => mobileControl.text;
  

    bool emailValid =true;
    bool passwordValid = true;
    bool firstnamevalid = true;
    bool lastnamevalid = true;
    bool addressvalid = true;
    bool agevalid = true;
    bool mobilevalid = true;

    bool loading = false;
  

  _onSubmit() async {
    var dontproceed = true;

    if(_email.isEmpty){
      setState(() {
        emailValid = false;
      });
      
      dontproceed =false;

    }
    if( _password.isEmpty){
       setState(() {
        passwordValid = false;
      });
     dontproceed =false;
    }
    if(_firstname.isEmpty){
       setState(() {
        firstnamevalid = false;
      });
       dontproceed =false;
    }
    if(_lastname.isEmpty){
       setState(() {
        lastnamevalid = false;
      });
       dontproceed =false;
    }
    if(_age.isEmpty){
      setState(() {
        agevalid = false;
      });
       dontproceed =false;
    }
    if(_mobileno.isEmpty || _mobileno.length < 10){
      setState(() {
        mobilevalid = false;
      });
       dontproceed =false;
    }
    if(_address.isEmpty){
      setState(() {
        addressvalid = false;
      });
       dontproceed =false;
    }

    if(dontproceed){
      setState(() {
         loading = true;
      });
     
    try{
      final _auth = Provider.of<FireBaseAuthService>(context,listen: false);
      final newuser = await _auth.createUserWithEmailAndPassword(_email, _password);
    // print(newuser.uid);
      if(newuser != null){
        UserDetails userDetails = UserDetails(
            firstname: _firstname,
            lastname: _lastname,
            email: _email,
            // password: _password,
            age: _age,
            address: _address,
            mobileno: _mobileno
        );

        await DatabaseService(uid: newuser.uid).updateuserdata(userDetails);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
          return ProfilePage();
          }),
        );
      }else{
        setState(() {
         loading = false;
      });
      }
    }on PlatformException catch(e){
        PlatFormExceptionAlertDialog(
        exception: e,  
        title: 'Sign UP failed',
        ).show(context);
        print(e); // print(e);
        setState(() {
         loading = false;
      });
    }finally{
      setState(() {
         loading = false;
        
      });
    }

    }

  }
  

  @override
  Widget build(BuildContext context) {

    // ScreenUtil.init(context, width: 393, height: 873, allowFontScaling: false);

    return loading ? Loading() : Scaffold(
      key: _signupScaffold,
      backgroundColor: Color(0xffffff),
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().setHeight(893),
          width: ScreenUtil().setWidth(393),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(300),
                width: ScreenUtil().setWidth(393),
                decoration: BoxDecoration(
                  color: Color(0xff042c38),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/MaskGroup-1.png',
                    ),
                    fit: BoxFit.fill,
                  ), 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children:<Widget>[ 
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(40),left: ScreenUtil().setWidth(20)),
                      child: GestureDetector(
                        onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
                              return SignInPage();
                              }),);
                            },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset('assets/images/Group62.png'),
                            Padding(
                              padding: EdgeInsets.only(left:ScreenUtil().setWidth(12)),
                                child: Text('Back',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ), 
                          ],
                          ),
                      ),
                      ),
                    ],
                  ),
                ),
              Positioned(
                  bottom: ScreenUtil().setWidth(0),
                  child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(393),
                      height: ScreenUtil().setWidth(600),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.rectangle, 
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                              // Icon(Icons.group),
                              Image.asset('assets/images/Icon-feather-user.png'),
                              // SvgPicture.asset('assets/images/user.svg'),
                                Padding(
                                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(32.0)),
                                  child: SizedBox(
                                    width: ScreenUtil().setWidth(270),
                                    child: TextField(
                                      controller: firstnamecontrol,
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                       onChanged: (val){
                                          if(val != ''){
                                          setState(() {
                                            firstnamevalid = true;
                                          });
                                        }
                                       },
                                      decoration: InputDecoration(
                                      hintText: 'FirstName',
                                      errorText: firstnamevalid ? null : widget.firstnameError,
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
                              // Icon(Icons.group),
                              Image.asset('assets/images/Icon-feather-user.png'),
                              
                                Padding(
                                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(32.0)),
                                  child: SizedBox(
                                    width: ScreenUtil().setWidth(270),
                                    child: TextField(
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      controller: lastnamecontrol,
                                       onChanged: (val){
                                          if(val.isNotEmpty){
                                          setState(() {
                                            lastnamevalid = true;
                                          });
                                        }
                                       },
                                      decoration: InputDecoration(
                                      hintText: 'LastName',
                                      errorText: lastnamevalid ? null : widget.lastnameError,
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
                                // Icon(Icons.email),
                                Image.asset('assets/images/Icon-feather-mail.png'),
                                Padding(
                                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(32.0)),
                                  child: SizedBox(
                                    width: ScreenUtil().setWidth(270),
                                    child: TextField(
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(30),
                                      ],
                                      controller: emailcontrol,
                                      onChanged: (val){
                                          if(val.isNotEmpty){
                                          setState(() {
                                            emailValid = true;
                                          });
                                        }
                                       },
                                      keyboardType: TextInputType.emailAddress,
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
                                  padding: EdgeInsets.only(left:ScreenUtil().setWidth(32.0)),
                                  child: SizedBox(
                                    width: ScreenUtil().setWidth(270),
                                    child: TextField(
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                       onChanged: (val){
                                          if(val.isNotEmpty){
                                          setState(() {
                                            passwordValid = true;
                                          });
                                        }
                                       },
                                      controller: passwordcontrol,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                      hintText: 'Password',
                                      errorText: passwordValid ? null : widget.passwordError,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // // Icon(Icons.email),
                                // Image.asset('assets/images/Icon-feather-mail.png'),
                                // Padding(
                                //   padding: EdgeInsets.only(left:ScreenUtil().setWidth(32.0)),
                                  // child: 
                                  SizedBox(
                                    width: ScreenUtil().setWidth(270),
                                    child: Row(
                                      children: <Widget>[
                                      SizedBox(
                                        width: ScreenUtil().setWidth(100),
                                        child: TextField(
                                          inputFormatters:[
                                        LengthLimitingTextInputFormatter(2),
                                          ],
                                          controller: ageControl,
                                          onChanged: (val){
                                              if(val.isNotEmpty){
                                              setState(() {
                                                agevalid = true;
                                              });
                                            }
                                           },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                          hintText: 'Age',
                                          errorText: agevalid ? null :  widget.ageError,
                                            hintStyle: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 30,),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(130),
                                        child: TextField(
                                          inputFormatters:[
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          controller: mobileControl,
                                          onChanged: (val){
                                              if(val.isNotEmpty){
                                              setState(() {
                                                mobilevalid = true;
                                              });
                                            }
                                           },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                          hintText: 'Mobile no',
                                          errorText: mobilevalid ? null :  widget.mobileError,
                                            hintStyle: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),
                                  ),
                                // ),
                              ],
                            ),
                            SizedBox(
                                  width: ScreenUtil().setWidth(280),
                                  child: TextField(
                                    inputFormatters:[
                                        LengthLimitingTextInputFormatter(20),
                                      ],
                                      decoration:  InputDecoration(
                                        errorText: addressvalid ? null :  widget.addressError,
                                          border:  OutlineInputBorder(

                                            borderRadius: BorderRadius.all(
                                               Radius.circular(ScreenUtil().setWidth(10)),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.grey[800]),
                                          hintText: "Address",
                                          fillColor: Colors.white70),
                                          controller: addressControl,
                                          keyboardType: TextInputType.text,
                                          onChanged: (val){
                                            if(val.isNotEmpty){
                                              setState(() {
                                                addressvalid = true;
                                              });  
                                            }
                                          },
                                    ),
                                ),
                            
                            FormSubmitButton(buttonType: 'SIGN UP', onPressed: _onSubmit)
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

  void showSnackBar(text){

      final snackbar = SnackBar(
        backgroundColor: Color(0xFF00a79b),
      content: Text(
          text,
          style: TextStyle(color:Colors.white,),
        ),
      );
    _signupScaffold.currentState.showSnackBar(snackbar);

  }
}