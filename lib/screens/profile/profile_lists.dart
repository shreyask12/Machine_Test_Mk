import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:machine_test_ex/models/userdetails.dart';


class ProfileLists extends StatelessWidget {

  final UserDetails profile;

  ProfileLists({this.profile});


  @override
  Widget build(BuildContext context) {
    // ScreenUtil size = ScreenUtil();
    return Padding(
      padding: EdgeInsets.only(top:ScreenUtil().setWidth(8)),
      child:
      Container(
        height: ScreenUtil().setHeight(893),
        width: ScreenUtil().setWidth(393),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/user-icon.png'),
                maxRadius: ScreenUtil().setWidth(60),
              ),
              
          Flexible(
            child: Text(
              profile.email ?? '',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: ScreenUtil().setSp(20),
                  color: Colors.teal[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
              width: ScreenUtil().setWidth(150),
              child: Divider(
                color: Colors.teal.shade900,
                ),
            ),
            
            CreateCard(icon: Icons.supervised_user_circle,subtext: profile.firstname,titletext: 'FirstName :',),
            CreateCard(icon: Icons.supervised_user_circle,subtext: profile.lastname,titletext: 'LastName :',),
            CreateCard(icon: Icons.phone,subtext: profile.mobileno,titletext: 'Phone :',),
            CreateCard(icon: Icons.date_range,subtext: profile.age,titletext: 'Age :',),
            CreateCard(icon: Icons.location_city,subtext: profile.address,titletext: 'Address :',),
          ]
        ),
      ),
    );
  }
}


class CreateCard extends StatelessWidget {

  final IconData icon;
  final String titletext;
  final String subtext;

  CreateCard({this.icon,this.titletext,this.subtext});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10),horizontal:ScreenUtil().setWidth(25)),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
          ),
        title: Text(
              titletext ?? "",
              style: TextStyle(
                color: Colors.teal.shade900,
                fontFamily: 'Source Sans Pro',
                fontSize: ScreenUtil().setSp(15),
              ),
            ),
            subtitle:Text(subtext ?? '',
              style: TextStyle(
                color: Colors.teal,
                fontFamily: 'Source Sans Pro',
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
        ),
      );
  }
}
