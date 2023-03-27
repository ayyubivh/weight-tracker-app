import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_management_app/core/common/loader.dart';
import 'package:weight_management_app/core/colors/colors.dart';
import 'package:weight_management_app/core/common/shimmer.dart';
import 'package:weight_management_app/service/auth_service.dart';
import 'package:weight_management_app/service/database_service.dart';
import 'package:weight_management_app/views/auth/screens/auth_screen.dart';
import 'package:weight_management_app/views/home/widgets/empty_weight.dart';
import 'package:weight_management_app/views/home/widgets/home_widgets.dart';
import 'package:weight_management_app/views/home/widgets/show_update_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? weights;
  String userName = "";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "WEIGHT TRACKER",
          style: TextStyle(
            color: kBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await AuthService().signout(context);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const AuthScreen()),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.logout,
                color: kBlack,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: weights,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['weight'] != null) {
              if (snapshot.data['weight'].length != 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data['weight'].length,
                    itemBuilder: (context, index) {
                      int reverseIndex =
                          snapshot.data['weight'].length - index - 1;
                      final data = snapshot.data['weight'];
                      return weightTile(data, reverseIndex, context, snapshot);
                    },
                  ),
                );
              } else {
                return const EmptyWeights();
              }
            } else {
              return const EmptyWeights();
            }
          }
          return ShimmerWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showAddWeightForm(context);
        },
        child: Icon(
          Icons.add,
          color: kBlack,
        ),
      ),
    );
  }

  Padding weightTile(data, int reverseIndex, BuildContext context,
      AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              kBlack,
              primaryColor.withOpacity(0.3),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: ListTile(
          title: Text(
            getWeight(data[reverseIndex]),
            style: TextStyle(
                color: kwhite, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            getDate(data[reverseIndex]),
            style: TextStyle(
              color: kwhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: CircleAvatar(
            backgroundColor: kwhite.withOpacity(0.7),
            child: IconButton(
                onPressed: () {
                  showDialoge(context, snapshot, reverseIndex);
                },
                icon: const Icon(Icons.delete, color: Colors.red)),
          ),
          onTap: () {
            showUpdateWeightForm(context, data, reverseIndex);
          },
        ),
      ),
    );
  }

  Future<dynamic> showDialoge(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int reverseIndex) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete ?"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            IconButton(
                onPressed: () {
                  DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                      .deleteWeight(snapshot.data['weight'][reverseIndex]);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ))
          ],
        );
      },
    );
  }
}

String getWeight(String res) {
  return res.substring(0, res.indexOf("_"));
}

String getDate(String res) {
  return res.substring(res.indexOf("_") + 1, 15);
}
