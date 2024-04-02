import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/pages/aboutus.dart';
import 'package:skillswap/pages/help.dart';
import 'package:skillswap/pages/privacyPolicy.dart';

class SettingsPage extends StatelessWidget {
  final String userName;
  
  const SettingsPage({
    Key? key,
    required this.userName,
  }) : super(key: key);

  Widget buildSettingItem({IconData? icon, String? title, required VoidCallback navigate,}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: navigate,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10.0),
            Text(
              title ?? '',
              style: TextStyle(color: Colors.black),
            ),
            const Spacer(),
            const Text('English', style: TextStyle(color: Colors.black)),
            const SizedBox(width: 10.0),
            Icon(Icons.navigate_next, color: Colors.black),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: const Row(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 90.0,
                width: 390,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromARGB(255, 29, 58, 84),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const CircleAvatar(),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '$userName@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.navigate_next, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 212, 202, 202),
                thickness: 1.0,
                indent: 30.0,
                endIndent: 30.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40.0, top: 10.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    navigate: (){}
                  ),
                  const SizedBox(height: 20.0),
                  buildSettingItem(
                    icon: Icons.language_rounded,
                    title: 'Language',
                    navigate: (){}
                  ),
                  const SizedBox(height: 20.0),
                  buildSettingItem(
                    icon: Icons.privacy_tip_sharp,
                    title: 'Privacy',
                     navigate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  buildSettingItem(
                    icon: Icons.help_center,
                    title: 'Help Center',
                     navigate: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HelpPage()),
                            );
                          },
                          ),
                  const SizedBox(height: 20.0),
                  buildSettingItem(
                    icon: Icons.info,
                    title: 'About Us',
                     navigate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}