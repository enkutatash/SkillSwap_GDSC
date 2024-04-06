import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/pages/contact.dart';
import 'package:skillswap/pages/setting.dart';

class SideBar extends StatelessWidget {
  final Map<String, dynamic> userdata;
  final String userid;

  SideBar(this.userdata, this.userid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ProjectController projectController = Get.put(ProjectController.empty());
    final UserController userController = Get.find();
    return Drawer(
      backgroundColor: Color.fromARGB(255, 237, 241, 245),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0XFF2E307A),
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                          imageUrl: userController.userdata['profilePic'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        '${userController.userdata['First']} ${userController.userdata['Last']} ',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          userdata: userdata,
                          userid: userid,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactPage()));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Color(0XFF2E307A),
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Color(0XFF2E307A)),
            ),
            onTap: () {
              projectController.clearProjects();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
