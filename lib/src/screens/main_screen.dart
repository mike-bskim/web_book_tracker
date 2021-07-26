import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/constants/constants.dart';
import 'package:flutter_web_book_tracker/src/model/book.dart';
import 'package:flutter_web_book_tracker/src/model/user.dart';
import 'package:flutter_web_book_tracker/src/screens/login_page.dart';
import 'package:flutter_web_book_tracker/src/widgets/book_details_dialog.dart';
import 'package:flutter_web_book_tracker/src/widgets/book_search_page.dart';
import 'package:flutter_web_book_tracker/src/widgets/create_profile.dart';
import 'package:flutter_web_book_tracker/src/widgets/reading_list_card.dart';
import 'package:provider/provider.dart';

class MainScreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference = FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference = FirebaseFirestore.instance.collection('books');
    List<Book> userBooksReadList = [];

    var authUser = Provider.of<User?>(context);
//    print('MainScreenPage >> authUser: ${authUser.toString()}');

//    int booksRead = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        toolbarHeight: 77,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/Icon-76.png',
              scale: 2,
            ),
            Text(
              'A.Reader',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final userListStream = snapshot.data!.docs.map((user) {
                return MUser.fromDocument(user);
              }).where((user) {
//                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
                return (user.uid == authUser!.uid);
              }).toList(); //[user]

              MUser curUser = userListStream[0];

              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(curUser.avatarUrl != null
                            ? curUser.avatarUrl!
                            : 'https://i.pravatar.cc/300'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            print('createProfileDialog');
                            return createProfileDialog(context, curUser, userBooksReadList);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      curUser.displayName.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookSearchPage(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, left: 12, bottom: 10),
            width: double.infinity,
            child: RichText(
                text: TextSpan(style: Theme
                    .of(context)
                    .textTheme
                    .headline5, children: [
                  TextSpan(text: 'Your reading\n activity '),
                  TextSpan(text: 'right now...', style: TextStyle(fontWeight: FontWeight.bold))
                ])),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: bookCollectionReference.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
//              print(snapshot.data!.docs.first.data().toString()); //cho@me.com
                var userBookFilteredReadListStream =
                snapshot.data!.docs.map((book) {
                  return Book.fromDocument(book);
                }).where((book) {
//                  return (book.userId == FirebaseAuth.instance.currentUser!.uid)
                  return (book.userId == authUser!.uid)
                      && (book.startedReading != null)
                      && (book.finishedReading == null);
                }).toList();

                userBooksReadList = snapshot.data!.docs.map((book) {
                  return Book.fromDocument(book);
                }).where((book) {
//                  return (book.userId == FirebaseAuth.instance.currentUser!.uid)
                  return (book.userId == authUser!.uid)
                      && (book.finishedReading != null)
                      && (book.startedReading != null);
                }).toList();
//                  booksRead = userBooksReadList.length;

                return Expanded(
                    flex: 1,
//                  height: 300,
                    child: (userBookFilteredReadListStream.length > 0)
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userBookFilteredReadListStream.length,
                      itemBuilder: (context, index) {
                        Book book = userBookFilteredReadListStream[index];

                        return InkWell(
                          child: ReadingListCard(
                            title: book.title,
                            author: book.author,
                            image: book.photoUrl,
                            buttonText: 'Reading',
                            pressRead: () {print('Reading');},
                            rating: book.rating != null ? (book.rating) : 0.5,
                          ),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) =>
                                BookDetailsDialog(book: book),
                          ),

                        );

                      },
                    )
                        : Center(
                      child: Text(
                        'You haven\'t started reading. \nStart by adding a book.',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                );
              }
          ),
          Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Reading List',
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))
                        ]
                      )
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 8,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bookCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              var readingListListBook = snapshot.data!.docs.map((book) {
                return Book.fromDocument(book);
              }).where((book) {
//                return (book.userId == FirebaseAuth.instance.currentUser!.uid)
                return (book.userId == authUser!.uid)
                    && (book.finishedReading == null)
                    && (book.startedReading == null)
                ;
              }).toList();

              return Expanded(
                  flex: 1,
//                  height: 300,
                  child: (readingListListBook.length > 0)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: readingListListBook.length,
                    itemBuilder: (context, index) {
                      Book book = readingListListBook[index];

                      return InkWell(
                        child: ReadingListCard(
                            buttonText: 'Not Started',
                            rating: book.rating != null ? (book.rating) : 4.0,
                            author: book.author,
                            image: book.photoUrl,
                            title: book.title,
                            pressRead: () {print('Not started');},
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) =>
                              BookDetailsDialog(book: book),
                        ),

                      );
                    },
                  )
                      : Center(
                      child: Text('No books found. Add a book :)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))));
            },
          )
        ],
      ),
    );
  }
}

