import 'dart:async';

import 'package:chatapp/BD/auth.dart';
import 'package:chatapp/BD/bd.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/discussion.dart';
import 'package:chatapp/widgets/Navigation.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:chatapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance.currentUser;
  Utilisateur? user;
  TextEditingController search = TextEditingController();
  GlobalKey<FormState> key2 = GlobalKey<FormState>();

  void getUser() async {
    user = await DBServices().getUserId(auth!.uid);
    Utilisateur.user = user;
    // print('le nom est : ${user!.userName}');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return user == null
        ? loading(context)
        : Scaffold(
            body: Stack(
              children: [
                const Background(),
                Container(
                  color:
                      const Color.fromARGB(255, 106, 1, 124).withOpacity(0.03),
                ),
                Center(
                  child: SizedBox(
                    width: width - 20,
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 52,
                              width: width - 77,
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
                            const SizedBox(width: 5),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 106, 1, 124),
                                    Color.fromARGB(255, 241, 3, 83),
                                    Color.fromARGB(255, 245, 180, 0),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: StreamBuilder<List<Utilisateur>>(
                            stream: DBServices()
                                .getDiscussionUser(user!.discussion),
                            builder: (_, s) {
                              if (s.hasData) {
                                final users = s.data;

                                return users!.length == 0
                                    ? const Center(
                                        child: Text('aucune discussion'),
                                      )
                                    : ListView.builder(
                                        itemCount: users.length,
                                        itemBuilder: (cxt, i) {
                                          final user = users[i];

                                          return ListTile(
                                            leading: user.pp == null
                                                ? const CircleAvatar(
                                                    radius: 23,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/logo.png'),
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage:
                                                        AssetImage(user.pp!),
                                                  ),
                                            title: Text(
                                              user.userName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: FutureBuilder(
                                              future: DBServices()
                                                  .getLastMessage(
                                                      auth!.uid, user.uid),
                                              builder: (context, s) {
                                                if (s.hasData) {
                                                  return Text(
                                                    s.data!.content,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  );
                                                } else if (s.hasError) {
                                                  print(s.error);
                                                  return const Text('');
                                                } else {
                                                  return const Text('');
                                                }
                                              },
                                            ),
                                            trailing: FutureBuilder(
                                              future: DBServices()
                                                  .countUnreadMessages(
                                                      auth!.uid, user.uid),
                                              builder: (context, s) {
                                                if (s.hasData) {
                                                  return s.data == 0
                                                      ? const Text('')
                                                      : Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                          .purple[
                                                                      800]),
                                                          child: Center(
                                                            child: Text(
                                                              "${s.data!}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        );
                                                } else if (s.hasError) {
                                                  print(s.error);
                                                  return const Text('');
                                                } else {
                                                  return const Text('');
                                                }
                                              },
                                            ),
                                            onTap: () {
                                              DBServices().markMessagesAsRead(
                                                  auth!.uid, user.uid);
                                              Navigates.navigateAndReplace(
                                                context,
                                                Discussion(
                                                  user: user,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                              } else if (s.hasError) {
                                print("il y'a erreur");
                                return Center(child: Text(s.error.toString()));
                              } else {
                                print("pas d'erreur, mais ca tourne");

                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         AuthService().signOut();
                        //       },
                        //       child: Text('Deconnexion'),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
