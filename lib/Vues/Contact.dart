// ignore_for_file: file_names

import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/discussion.dart';
import 'package:chatapp/controller/ContactController.dart';
import 'package:chatapp/widgets/Navigation.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:chatapp/widgets/loading.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contacts_service/contacts_service.dart' as contacts;

// class Contact {
//   final String name;
//   final String phoneNumber;

//   Contact({required this.name, required this.phoneNumber});
// }

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Utilisateur>? users = [];

  TextEditingController search = TextEditingController();
  GlobalKey<FormState> key2 = GlobalKey<FormState>();
  bool load = false;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    Utilisateur.loadUsersFromLocalStorage();
    users = Utilisateur.users;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (users == null)
          ? loading(context)
          : Stack(
              children: [
                const Background(),
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 52,
                              width: width - 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 106, 1, 124),
                                    Color.fromARGB(255, 241, 3, 83),
                                    Color.fromARGB(255, 245, 180, 0),
                                    Color.fromARGB(255, 106, 1, 124),
                                    Color.fromARGB(255, 241, 3, 83),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Form(
                                  key: key2,
                                  child: SizedBox(
                                    height: 50,
                                    width: width - 80,
                                    child: TextFormField(
                                      validator: (value) =>
                                          value!.isEmpty ? '' : null,
                                      controller: search,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            (load == true)
                                ? const CircularProgressIndicator()
                                : Text(
                                    "${users!.length} \n Contacts",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert_outlined),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      value: 'actualiser',
                                      child: const Text('Actualiser'),
                                      onTap: () async {
                                        load = true;
                                        setState(() {});
                                        final u = await ContactController()
                                            .actualualiseContact();
                                        users = u;
                                        if (u.isNotEmpty) {
                                          load = false;
                                        }
                                        setState(() {});
                                      }),
                                  const PopupMenuItem(
                                    value: 'inviter',
                                    child: Text('Inviter un contact'),
                                  ),
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: users!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: users![index].pp == null
                                ? const CircleAvatar(
                                    radius: 23,
                                    backgroundImage:
                                        AssetImage('assets/images/logo.png'),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(users![index].pp!),
                                  ),
                            title: Text(users![index].userName),
                            subtitle: Text(users![index].tel),
                            onTap: () => Navigates.navigateAndReplace(
                              context,
                              Discussion(
                                user: users![index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
