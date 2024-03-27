import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/firebase/skills.dart';
import 'package:skillswap/homepage/homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _emailnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _linkedincontroller = TextEditingController();
  final _githubcontroller = TextEditingController();
  final _biocontroller = TextEditingController();
  late final Firebase_Service _auth;
  List<String> _selectedSkills = [];

  bool _obscureText = true;
  String? imagePath;
  File? _image;
  String? downloadUrl;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // For mobile platforms, set the image directly
    final imageTemp = File(image.path);
    setState(() {
      imagePath = imageTemp.path;
      _image = imageTemp;
    });
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}.jpg');

    try {
      // Upload the image to Firebase Storage
      await storageReference.putFile(_image!);

      // Retrieve the download URL of the uploaded image
      downloadUrl = await storageReference.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _auth = Firebase_Service(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset('asset/animation.json'),
                ),
                const Text(
                  "SkillSwap",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : NetworkImage(
                              "https://images.rawpixel.com/image_png_social_square/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png"),
                      child: imagePath == null ? Icon(Icons.person) : null,
                    ),
                    Positioned(
                        top: 45,
                        right: -10,
                        child: IconButton(
                            onPressed: pickImage,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Color(0XFF6055D8),
                            )))
                  ]),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      height: height * 0.06,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white, // Set border color to red
                          width: 2.0, // Set border width to 2 pixels (optional)
                        ),
                      ),
                      child: TextFormField(
                        controller: _firstnameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your First name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Container(
                      width: width * 0.4,
                      height: height * 0.06,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white, // Set border color to red
                          width: 2.0, // Set border width to 2 pixels (optional)
                        ),
                      ),
                      child: TextFormField(
                        controller: _lastnameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to red
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailnameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to red
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // toggle password visibility
                          setState(() {
                            _passwordController.text =
                                _passwordController.text.replaceAll('•', '');
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8 || value.length > 16) {
                        return 'Password must be between 8 and 16 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Github",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to white
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _githubcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Linked In",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to white
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _linkedincontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Bio",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.2, // Adjust the height as needed
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Set border color
                      width: 2.0, // Set border width (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _biocontroller,
                    maxLines:
                        null, // Allows the text field to expand to multiple lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Bio here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Dropdown(
                  onItemsSelected: (selectedItems) {
                    setState(() {
                      _selectedSkills = selectedItems;
                    });
                  },
                ),
                SizedBox(height: height * 0.03),
                Button("Sign Up", Colors.white, Colors.red, () {
                  if (_formKey.currentState!.validate()) {
                    // form is valid, submit the form
                    _signUp();
                  }
                }),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account? ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some action to take when the user presses the action button
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _signUp() async {
    String email = _emailnameController.text;
    String password = _passwordController.text;
    String firstName = _firstnameController.text;
    String lastName = _lastnameController.text;
    String linkedin = _linkedincontroller.text;
    String github = _githubcontroller.text;
    String bio = _biocontroller.text;

    User? user = await _auth.signUpWithEmailAndPassword(firstName, lastName,
        email, password, downloadUrl!, linkedin, github, bio,_selectedSkills);
    if (user != null) {
      print("User is successfully created");
      Map<String, dynamic> userdata = {
        'Email': email,
        'First': firstName,
        'Last': lastName,
        'password': password,
        'profilePic': downloadUrl,
        'Bio': bio,
        'Id': user.uid,
        'Skills': _selectedSkills
      };
      print(_selectedSkills);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Homepage(user.uid, userdata)));
      _showSnackBar("User is successfully created");
    } else {
      print("Some error happend on create user");
      _showSnackBar("Some error happend on create user");
    }
  }
}

Widget textfield(
  String hint,
  IconData icon,
  TextEditingController controller,
  TextInputType keyboardType, {
  IconData? suffixIcon,
  double? width,
  double? height,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
    ),
  );
}

class Button extends StatelessWidget {
  final String text;
  final Color btnclr;
  final Color textclr;
  final void Function() click;
  Button(this.text, this.textclr, this.btnclr, this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: click,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Set border radius
          ),
        ),
        minimumSize: MaterialStateProperty.all(
            Size(width * 0.8, height * 0.07)), // Set width and height
        backgroundColor:
            MaterialStateProperty.all<Color>(btnclr), // Set color to red
      ),
      child: Text(
        text,
        style: TextStyle(color: textclr),
      ),
    );
  }
}