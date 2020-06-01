import 'package:flutter/material.dart';
import 'package:machine_test_ex/models/user.dart';
import 'package:machine_test_ex/models/userdetails.dart';
import 'package:machine_test_ex/screens/profile/profile_lists.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {

    List tempArray = List();
    final profiles = Provider.of<List<UserDetails>>(context) ?? [];
    final user = Provider.of<User>(context,listen:false);
    // print(user.uid);
    if(profiles != null){
      
        profiles.forEach((e) {
          if(e.uid == user.uid){
          setState(() {
            tempArray.add(e);

          });
           
          }
        });
        // print(tempArray);
       
    }
    
    return ListView.builder(
      itemCount: tempArray.length,
      itemBuilder: (context,index){
        return ProfileLists(profile : tempArray[index]);
      }
    );
    
  }
}