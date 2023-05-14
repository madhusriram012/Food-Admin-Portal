import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_web_portal/authentication/login_screen.dart';
import 'package:admin_web_portal/riders/all_blocked_riders_screen.dart';
import 'package:admin_web_portal/riders/all_verified_riders_screen.dart';
import 'package:admin_web_portal/sellers/all_blocked_sellers_screen.dart';
import 'package:admin_web_portal/sellers/all_verified_sellers_screen.dart';
import 'package:admin_web_portal/users/all_blocked_users_screen.dart';
import 'package:admin_web_portal/users/all_verified_users_screen.dart';
import 'package:intl/intl.dart';



class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xffdfe8f1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xff464646),
          ),
        ),
        title: const Text(
          "Admin Web Portal",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  "  "+timeText + "\n " + dateText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //users activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                Container(
                  height: 100,
                  width: 350,

                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.black,),
                    label: Text(
                      "All Verified Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedUsersScreen()));
                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  height: 100,
                  width: 350,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.black,),
                    label: Text(
                      "All Blocked Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedUsersScreen()));
                    },
                  ),
                ),
              ],
            ),

            //sellers activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                Container(
                  height: 100,
                  width: 350,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.black,),
                    label: Text(
                      "All Verified Sellers".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedSellersScreen()));
                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  height: 100,
                  width: 350,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.black,),
                    label: Text(
                      "All Blocked Sellers".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedSellersScreen()));
                    },
                  ),
                ),
              ],
            ),

            //riders activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                Container(
                  height: 100,
                  width: 350,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.black,),
                    label: Text(
                      "All Verified Riders".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedRidersScreen()));
                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  height: 100,
                  width: 350,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.black,),
                    label: Text(
                      "All Blocked Riders".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedRidersScreen()));
                    },
                  ),
                ),
              ],
            ),

            //logout button
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white,),
              label: Text(
                "Logout".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(30),
                backgroundColor: Color(0xffee547b),
                shadowColor: Color(0xfff37f9c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: ()
              {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
