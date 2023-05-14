import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';


class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async
  {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credentials, Please wait...",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xffee547b),
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    ).then((fAuth)
    {
      //success
      currentAdmin = fAuth.user;
    }).catchError((onError)
    {
      //in case of error
      //display error message
      final snackBar = SnackBar(
        content: Text(
          "Error Occured: " + onError.toString(),
          style: const TextStyle(
            fontSize: 36,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if(currentAdmin != null)
    {
      //check if that admin record also exists in the admins collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get().then((snap)
      {
        if(snap.exists)
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }
        else
        {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "No record found, you are not an admin.",
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.pinkAccent,
            duration: Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff464646),
        title:const Text("ADMIN LOGIN PORTAL",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Color(0xffebf0f6),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  Image.asset(
                      "images/admin.png",
                  ),

                  //email text field
                  TextField(
                    onChanged: (value)
                    {
                      adminEmail = value;
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color:Color(0xffee547b),
                            width: 2,
                          )
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Color(0xffee547b),
                            width: 2,
                          )
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.grey),
                      icon: const Icon(
                        Icons.email,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  //password text field
                  TextField(
                    onChanged: (value)
                    {
                      adminPassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration:InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.pinkAccent,
                            width: 2,
                          )
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pinkAccent,
                            width: 2,
                          )
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      icon: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  //button login
                  ElevatedButton(
                    onPressed: ()
                    {
                      allowAdminToLogin();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>( Color(0xffee547b),),
                      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffee547b),),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
