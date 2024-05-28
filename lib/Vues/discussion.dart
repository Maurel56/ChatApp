import 'package:chatapp/BD/bd.dart';
import 'package:chatapp/Modeles/Message.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/navBar.dart';
import 'package:chatapp/widgets/MessageComponent.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Discussion extends StatefulWidget {
  Utilisateur user;
  Discussion({super.key, required this.user});

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> with WidgetsBindingObserver {
  TextEditingController Msg = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<Message> messages = [];
  bool isActive = true;
  final auth = FirebaseAuth.instance.currentUser;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        isActive = true;
      });
    } else {
      setState(() {
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utilisateur user = widget.user;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Row(
            children: [
              user.pp == null
                  ? const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/logo.jpg"),
                    )
                  : CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(user.pp!),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    isActive
                        ? "en ligne"
                        : user.lastConnection == null
                            ? ''
                            : "${user.lastConnection!.toDate().hour} : ${user.lastConnection!.toDate().minute}",
                    style:
                        TextStyle(fontSize: 12, color: Colors.tealAccent[700]),
                  )
                ],
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            const Background(),
            Column(
              children: [
                // Début de la liste de messagerie

                Expanded(
                  flex: 9,
                  child: StreamBuilder<List<Message>>(
                    stream: DBServices().getMessage(widget.user.uid),
                    builder: (context, s1) {
                      if (s1.hasData) {
                        return StreamBuilder<List<Message>>(
                          stream:
                              DBServices().getMessage(widget.user.uid, false),
                          builder: (context, s2) {
                            if (s2.hasData) {
                              var messages = [...s1.data!, ...s2.data!];
                              messages.sort((i, j) => i.time.compareTo(j.time));
                              messages = messages.reversed.toList();
                              return messages.length == 0
                                  ? const Center(
                                      child: Text('aucun message'),
                                    )
                                  : ListView.builder(
                                      reverse: true,
                                      // controller: _scrollController,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: messages.length,
                                      itemBuilder: (context, Index) {
                                        final msg = messages[Index];

                                        final todayDate = DateTime.now();
                                        final today = DateTime(todayDate.year,
                                            todayDate.month, todayDate.day);
                                        final yesterday = DateTime(
                                            todayDate.year,
                                            todayDate.month,
                                            todayDate.day - 1);
                                        return MessageComponent(
                                          msg: msg,
                                        );
                                      });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),

                // fin de la liste de messagerie

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
                          key: key,
                          child: SizedBox(
                            height: 50,
                            width: width - 80,
                            child: TextFormField(
                              validator: (value) => value!.isEmpty ? '' : null,
                              controller: Msg,
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.emoji_emotions_outlined,
                                    color: Color.fromARGB(255, 241, 3, 83),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Color.fromARGB(255, 241, 3, 83),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              Message msg = Message(
                                content: Msg.text,
                                senderId: auth!.uid,
                                receiverId: user.uid,
                                type: MessageType.Text,
                                time: Timestamp.now(),
                                isDelivered: false,
                                isRead: false,
                              );
                              DBServices().sendMessage(msg);
                              if (user.discussion != null &&
                                  !user.discussion!.contains(auth!.uid)) {
                                user.discussion!.add(auth!.uid);
                                DBServices().updateDiscussionList(
                                    user.discussion!, user.uid);
                              } else if (user.discussion == null) {
                                user.discussion = [];
                                user.discussion!.add(auth!.uid);
                                DBServices().updateDiscussionList(
                                    user.discussion!, user.uid);
                              }
                              if (!Utilisateur.user!.discussion!
                                  .contains(user.uid)) {
                                Utilisateur.user!.discussion!.add(user.uid);
                                DBServices().updateDiscussionList(
                                    Utilisateur.user!.discussion!, auth!.uid);
                              }
                              Msg.clear();
                              setState(() {});
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
