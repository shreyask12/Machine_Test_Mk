import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_ex/models/user.dart';
import 'package:machine_test_ex/models/userdetails.dart';
// import 'package:machine_test_ex/services/auth_service.dart';
import 'package:machine_test_ex/services/database_service.dart';
import 'package:machine_test_ex/shared/loader.dart';
import 'package:provider/provider.dart';

class EditForm extends StatefulWidget {

  // final userid;
  // EditForm({this.userid});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {

  final _formkey = GlobalKey<FormState>();

  String _firstname;
  String _lastname;
  String _address;
  String _mobileno;
  String _age;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context,listen: false);
    

    return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) { 
           
          return StreamBuilder<UserData>(
          stream: DatabaseService(uid : user.uid).userData,
          builder: (context, snapshot) {
            if(snapshot.hasData){

             UserData userData = snapshot.data;

            return Form(
              key: _formkey, 
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Text('Update your Profile Details',
                  style: TextStyle(fontSize:ScreenUtil().setSp(20),color: Color(0xff00a79b)),),
                  SizedBox(height:ScreenUtil().setHeight(15)),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters:[
                      LengthLimitingTextInputFormatter(15),
                    ],
                    initialValue: userData.firstname,
                   decoration: InputDecoration(
                     hintText: 'Firstname'
                   ), 
                    validator: (val) => val.isEmpty ? 'Please enter firstname' : null,
                    onChanged: (val) => setState(() => _firstname = val),
                  ),
                  SizedBox(height:ScreenUtil().setHeight(15)),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters:[
                      LengthLimitingTextInputFormatter(15),
                    ],
                    initialValue: userData.lastname,
                   decoration: InputDecoration(
                     hintText: 'Lastname'
                   ), 
                    validator: (val) => val.isEmpty ? 'Please enter lastname' : null,
                    onChanged: (val) => setState(() => _lastname = val),
                  ),
                  SizedBox(height:ScreenUtil().setHeight(15)),
                  TextFormField(
                    inputFormatters:[
                      LengthLimitingTextInputFormatter(10),
                    ],
                    initialValue: userData.mobileno,
                    
                   decoration: InputDecoration(
                     hintText: 'Mobile'
                     
                   ), 
                   keyboardType: TextInputType.number,
                    validator: (val) => val.isEmpty ? 'Please enter Mobile' : null,
                    onChanged: (val) => setState(() => _mobileno = val),
                  ),
                    TextFormField(
                      initialValue: userData.age,
                      inputFormatters:[
                        LengthLimitingTextInputFormatter(2),
                      ],
                   decoration: InputDecoration(
                     hintText: 'Age',
                   ), 
                   keyboardType: TextInputType.number,
                    validator: (val) => val.isEmpty ? 'Please enter age' : null,
                    onChanged: (val) => setState(() => _age = val),
                  ),
                  SizedBox(height:ScreenUtil().setHeight(15)),
                  TextFormField(
                      inputFormatters:[
                        LengthLimitingTextInputFormatter(20),
                      ],
                    initialValue: userData.address,
                   decoration: InputDecoration(
                     hintText: 'Address'
                   ), 
                   keyboardType: TextInputType.text,
                    validator: (val) => val.isEmpty ? 'Please enter Address' : null,
                    onChanged: (val) => setState(() => _address = val),
                  ),
                  SizedBox(height:ScreenUtil().setHeight(15)),
                  RaisedButton(
                    color:Color(0xff00a79b),
                    child: Text('Update',
                    style: TextStyle(color:Colors.white),
                    ),

                    onPressed: () async {
                   
                    if(_formkey.currentState.validate()){
                      UserDetails updatedUserData = UserDetails(
                        email: userData.email,
                        firstname: _firstname ?? userData.firstname,
                        lastname:  _lastname ?? userData.lastname,
                        age: _age ?? userData.age,
                        address:  _address ?? userData.address,
                        mobileno:  _mobileno ?? userData.mobileno,
                      );
                      await DatabaseService(uid:user.uid).updateuserdata(updatedUserData);
                      Navigator.pop(context);
                    }else{
                      
                    }
                      
                    }
                  ),
                ],
              ),
            );
            } else {
              return Loading();
            }
           
          }
        );
      }
    );
  }
}