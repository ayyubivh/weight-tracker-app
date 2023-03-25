import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_management_app/core/colors/colors.dart';
import 'package:weight_management_app/views/auth/service/auth_service.dart';
import 'package:weight_management_app/views/auth/service/database_service.dart';
import 'package:weight_management_app/views/home/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? weights;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserWeights()
        .then((snapshot) {
      setState(() {
        weights = snapshot;
      });
    });
  }

  String getWeight(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getDate(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: weights,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data['weight'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      // height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor.withOpacity(0.1),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                snapshot.data['weight'][index],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    DatabaseService(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .deleteWeight(
                                            snapshot.data['weight'][index]);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red))
                            ],
                          ),
                          // Text(
                          //   getDate(snapshot.data['weight'][index]),
                          //   style: TextStyle(color: Colors.black, fontSize: 20),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          _showAddWeightForm(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWeightForm(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              width: double.infinity,
              child: const ShowAddweightForm()),
        );
      },
    );
  }
}

String parsedate(DateTime date) {
  final _date = DateFormat().add_MMMd().format(date);
  final _splitdate = _date.split(" ");
  return '${_splitdate.last}\n${_splitdate.first}';
}
