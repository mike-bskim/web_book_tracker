import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/model/book.dart';
import 'package:flutter_web_book_tracker/src/model/user.dart';
import 'package:flutter_web_book_tracker/src/screens/login_page.dart';
import 'package:flutter_web_book_tracker/src/widgets/create_profile.dart';
import 'package:flutter_web_book_tracker/src/widgets/input_decoration.dart';
//import 'package:provider/provider.dart';

class MainScreenPage extends StatelessWidget {
//  final TextEditingController _displayNameTextController = TextEditingController();
//  final TextEditingController _professionTextContorller = TextEditingController();
//  final TextEditingController _quoteTextController = TextEditingController();
//  final TextEditingController _avatarTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference = FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference = FirebaseFirestore.instance.collection('books');
//    List<Book> userBooksReadList = [];

//    var authUser = Provider.of<User>(context);

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
              style: Theme.of(context)
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
//                return (user.uid == authUser.uid);
                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
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
                            return AlertDialog(
                              content: Container(
                                height: 700,
                                width: 400,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              curUser.avatarUrl ?? 'https://i.pravatar.cc/300'),
                                          radius: 60,
                                        )
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 8)),
                                    Text(
                                      'Books Reader',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.pinkAccent),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 8)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(curUser.displayName.toUpperCase(),
                                              style: Theme.of(context).textTheme.subtitle1),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return createProfileDialog(context, curUser);
//                                                return createProfileDialog(
//                                                    curUser: curUser,
//                                                    displayNameTextController:
//                                                        _displayNameTextController,
//                                                    professionTextContorller:
//                                                        _professionTextContorller,
//                                                    quoteTextController: _quoteTextController,
//                                                    avatarTextController: _avatarTextController
//                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.mode_edit,
                                            color: Colors.black12,
                                          ),
                                          label: Text(''),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${curUser.profession}',
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 2,
                                      child: Container(
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(width: 2, color: Colors.blueGrey.shade100),
                                          color: Color(0xfff1f3f6),
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Favorite Quote: ',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 2,
                                              child: Container(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  curUser.quote == null
                                                      ? ' "Life is great..." '
                                                      : '" ${curUser.quote}  "',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), //Text(curUser.displayName),
                            );
                            // return createProfileMobile(context, userListStream,
                            //     FirebaseAuth.instance.currentUser, null);
//                            return createProfileDialog(
//                                context, curUser, userBooksReadList);
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    curUser.displayName.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
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
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => BookSearchPage(),
//              ));
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
                text: TextSpan(style: Theme.of(context).textTheme.headline5, children: [
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

              final bookListStream = snapshot.data!.docs.map((book) {
                return Book.fromMap(book.data() as Map<String, dynamic>);
              }).toList();
              Book book = bookListStream[0];
              return Text(book.author);

//              var userBookFilteredReadListStream =
//              snapshot.data!.docs.map((book) {
//                return Book.fromDocument(book);
//              }).where((book) {
//                return (book.userId == authUser.uid) &&
//                    (book.finishedReading == null) &&
//                    (book.startedReading != null);
//              }).toList();

//              for (var item in userBookFilteredReadListStream) {
//                print(item.notes);
//              }

//              return ListView.builder(
//                itemCount: userBookFilteredReadListStream.length,
//                itemBuilder: (context, index) {
//                  return Text(userBookFilteredReadListStream[index].notes);
//              }
//            );
//              userBooksReadList = snapshot.data.docs.map((book) {
//                return Book.fromDocument(book);
//              }).where((book) {
//                return (book.userId == authUser.uid) &&
//                    (book.finishedReading != null) &&
//                    (book.startedReading != null);
//              }).toList();
              //  booksRead = userBooksReadList.length;

//              return Expanded(
//                flex: 1,
//                child: (userBookFilteredReadListStream.length > 0)
//                    ? ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  itemCount: userBookFilteredReadListStream.length,
//                  itemBuilder: (context, index) {
//                    Book book = userBookFilteredReadListStream[index];
//
//                    return InkWell(
//                      child: ReadingListCard(
//                        rating: book.rating != null ? (book.rating) : 4.0,
//                        buttonText: 'Reading',
//                        title: book.title,
//                        author: book.author,
//                        image: book.photoUrl,
//                      ),
//                      onTap: () {
//                        showDialog(
//                          context: context,
//                          builder: (context) {
//                            return BookDetailsDialog(
//                              book: book,
//                            );
//                          },
//                        );
//                      },
//                    );
//                  },
//                )
//                    : Center(
//                    child: Text(
//                        'You haven\'t started reading. \nStart by adding a book.',
//                        style: TextStyle(
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold,
//                        ))),
//              );
            },
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
//                                  color: kBlackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))
                    ])),
                  )
                ],
              )),
          SizedBox(
            height: 8,
          ),
//          StreamBuilder<QuerySnapshot>(
//            stream: bookCollectionReference.snapshots(),
//            builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.waiting) {
//                return CircularProgressIndicator();
//              }
////              var readingListListBook = snapshot.data.docs.map((book) {
////                return Book.fromDocument(book);
////              }).where((book) {
////                return (book.userId == authUser.uid) &&
////                    (book.finishedReading == null) &&
////                    (book.startedReading == null);
////              }).toList();
//
////              return Expanded(
////                  flex: 1,
////                  child: (readingListListBook.length > 0)
////                      ? ListView.builder(
////                    scrollDirection: Axis.horizontal,
////                    itemCount: readingListListBook.length,
////                    itemBuilder: (context, index) {
////                      Book book = readingListListBook[index];
////
////                      return InkWell(
////                        child: ReadingListCard(
////                            buttonText: 'Not Started',
////                            rating:
////                            book.rating != null ? (book.rating) : 4.0,
////                            author: book.author,
////                            image: book.photoUrl,
////                            title: book.title),
////                        onTap: () => showDialog(
////                          context: context,
////                          builder: (context) =>
////                              BookDetailsDialog(book: book),
////                        ),
////                      );
////                    },
////                  )
////                      : Center(
////                      child: Text('No books found. Add a book :)',
////                          style: TextStyle(
////                            fontSize: 18,
////                            fontWeight: FontWeight.bold,
////                          ))));
//            },
//          )
        ],
      ),
    );
  }
}

