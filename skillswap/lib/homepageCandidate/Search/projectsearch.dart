import 'package:flutter/material.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/Search/projectdetailtojoin.dart';
import 'package:skillswap/widgets/buttons.dart';

//   late Firebase_Service _auth;
//   late Map<String, dynamic> ownerdata;

//   @override
// void initState() {
//   super.initState();
//   _auth = Firebase_Service(context);
//   _auth.userdataTwo(widget.projectdata['Owner']).then((userData) {
//     setState(() {
//       ownerdata = userData;
//     });
//   }).catchError((error) {
//     print("Error fetching owner data: $error");
//   });
// }
class ProjectSearch extends StatelessWidget {
  Map<String, dynamic> projectdata;
  ProjectSearch(this.projectdata, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailJoin(projectdata: projectdata)));
        },
        child: Container(
          width: width,
          height: height * 0.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 237, 241, 245),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
                spreadRadius: 1, // Extends the shadow beyond the box
                blurRadius: 1, // Blurs the edges of the shadow
                offset: Offset(0, 1), // Shifts the shadow (x, y)
              ),
            ],
          ),
          child: Stack(children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  child: Image.network(
                      height: height * 0.11,
                      width: width,
                      fit: BoxFit.cover,
                      projectdata['Projectimg']),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${projectdata['ProjectTitle']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              '${projectdata['ProjectDes']}',
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      ButtonTwo("Join", Colors.white, Color(0XFF2E307A),
                          width * 0.08, height * 0.05, 12, () {}),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: height * 0.07,
              left: width * 0.04,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 237, 241, 245),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(0, -2),
                      ),
                    ]),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        // ownerdata['profilePic'],
                        "asset/image 1.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      // '${ownerdata['First']} ${ownerdata['Last']}',
                      "Alice Bob",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
