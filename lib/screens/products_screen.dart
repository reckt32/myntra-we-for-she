import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myntra/helper/helper_function.dart';
import 'package:myntra/screens/chat_screen.dart';
import 'package:myntra/services/database_service.dart';
import 'package:myntra/widgets/group_tile.dart';
import 'package:myntra/widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Stream? groups;
  String userName = "";
  String email = "";
  Map<String, dynamic> products = {
    'product1': {
      'name': 'Product 1',
      'price': 100,
    },
    'product2': {
      'name': 'Product 2',
      'price': 200,
    },
    'product3': {
      'name': 'Product 3',
      'price': 300,
    },
    'product4': {
      'name': 'Product 4',
      'price': 400,
    },
  };

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  sendProduct(String groupId, String productName) {
    Map<String, dynamic> chatMessageData = {
      "message": productName,
      "sendBy": userName,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
    DatabaseService().sendMessage(groupId, chatMessageData);
  }

  //  groupList() {
  //   return StreamBuilder(
  //     stream: groups,
  //     builder: (context, AsyncSnapshot snapshot) {
  //       // make some checks
  //       if (snapshot.hasData) {
  //         if (snapshot.data['groups'] != null) {
  //           if (snapshot.data['groups'].length != 0) {
  //             return ListView.builder(
  //               itemCount: snapshot.data['groups'].length,
  //               itemBuilder: (context, index) {
  //                 int reverseIndex = snapshot.data['groups'].length - index - 1;
  //                 return GroupTile(
  //                     groupId: getId(snapshot.data['groups'][reverseIndex]),
  //                     groupName: getName(snapshot.data['groups'][reverseIndex]),
  //                     userName: snapshot.data['fullName']);
  //               },
  //             );
  //           } else {
  //             return noGroupWidget();
  //           }
  //         } else {
  //           return noGroupWidget();
  //         }
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(
  //               color: Theme.of(context).primaryColor),
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(children: [
              Image.network(
                  'https://images.unsplash.com/photo-1516762689617-e1cffcef479d?q=80&w=1911&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ListTile(
                  title: Text(products.values.elementAt(index)['name']),
                  subtitle: Text(
                      products.values.elementAt(index)['price'].toString()),
                  trailing: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Send Product'),
                                  content: groupList(products.values
                                      .elementAt(index)['name']));
                            });
                      })),
            ]);
          }),
    );
  }

  groupList(String productname) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data['groups'].length - index - 1;
                    return ListTile(
                      title: Text(
                        getName(snapshot.data['groups'][reverseIndex]),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await sendProduct(
                                getId(snapshot.data['groups'][reverseIndex]),
                                productname);
                            nextScreen(
                                context,
                                ChatPage(
                                    groupId: getId(
                                        snapshot.data['groups'][reverseIndex]),
                                    groupName: getName(
                                        snapshot.data['groups'][reverseIndex]),
                                    userName: userName));
                          },
                          icon: Icon(Icons.send)),
                    );
                  },
                ),
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
