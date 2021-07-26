import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_web_book_tracker/src/constants/constants.dart';
import 'package:flutter_web_book_tracker/src/model/book.dart';
import 'package:flutter_web_book_tracker/src/screens/main_screen.dart';
import 'package:flutter_web_book_tracker/src/util/util.dart';
import 'package:flutter_web_book_tracker/src/widgets/input_decoration.dart';
import 'package:flutter_web_book_tracker/src/widgets/two_sided_roundbutton.dart';
//import '../util/util.dart';
//import 'package:rating_bar/rating_bar.dart';

class BookDetailsDialog extends StatefulWidget {
  const BookDetailsDialog({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _BookDetailsDialogState createState() => _BookDetailsDialogState();
}

class _BookDetailsDialogState extends State<BookDetailsDialog> {
  bool isReadingClicked = false;
  bool isFinishedReadingClicked = false;

  double? _rating;
  final _bookCollectionReference = FirebaseFirestore.instance.collection('books');
  TextEditingController? _notestTextController;
  TextEditingController? _titleTextController;
  TextEditingController? _authorTextController;
  TextEditingController? _photoTextController;

  @override
  void initState() {
    _notestTextController = TextEditingController(text: widget.book.notes);
    _titleTextController = TextEditingController(text: widget.book.title);
    _authorTextController = TextEditingController(text: widget.book.author);
    _photoTextController = TextEditingController(text: widget.book.photoUrl);

    if (widget.book.rating == null) {
      print('widget.book.rating is null');
    } else {
      _rating = widget.book.rating;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

//    print('(build)widget.book.rating: ${widget.book.rating.toString()}');
//    print('_titleTextController: ${_titleTextController.text.toString()}');
//    print('_authorTextController: ${_authorTextController.text.toString()}');
//    print('_photoTextController: ${_photoTextController.text.toString()}');
//    print('_notestTextController: ${_notestTextController!.text.toString()}');

    return AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
//              Spacer(),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.book.photoUrl!),
                radius: 50,
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                    label: Text('Close')),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.book.author)
        ],
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _titleTextController,
                    decoration:
                        buildInputDecoration(label: 'Book title', hintText: 'Flutter Development'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _authorTextController,
                    decoration: buildInputDecoration(label: 'Author', hintText: 'Jeff A.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _photoTextController,
                    decoration: buildInputDecoration(label: 'Book cover', hintText: ''),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                    onPressed: widget.book.startedReading == null
                        ? () {
                            setState(() {
                              isReadingClicked = !isReadingClicked;
//                              if (isReadingClicked == false) {
//                                isReadingClicked = true;
//                              } else {
//                                isReadingClicked = false;
//                              }
                            });
                          }
                        : null,
                    icon: Icon(Icons.book_sharp),
                    label: (widget.book.startedReading == null)
                        ? (!isReadingClicked)
                            ? Text('Start Reading')
                            : Text('Started Reading...',
                                style: TextStyle(color: Colors.blueGrey.shade300),)
                        : Text('Started on: ${formatDate(widget.book.startedReading!)}')),
                TextButton.icon(
                    onPressed: widget.book.finishedReading == null
                        ? () {
                            setState(() {
                              isFinishedReadingClicked = !isFinishedReadingClicked;
//                              if (isFinishedReadingClicked == false) {
//                                isFinishedReadingClicked = true;
//                              } else {
//                                isFinishedReadingClicked = false;
//                              }
                            });
                          }
                        : null,
                    icon: Icon(Icons.done),
                    label: (widget.book.finishedReading == null)
                        ? (!isFinishedReadingClicked)
                            ? Text('Mark as Read')
                            : Text('Finished Reading!',
                                style: TextStyle(color: Colors.grey),)
                        : Text('Finished on ${formatDate(widget.book.finishedReading!)}')),
                RatingBar.builder(
                    allowHalfRating: true,
                    initialRating: widget.book.rating != null ? widget.book.rating! : 2.5,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                        case 5:
                          return Icon(
                            Icons.edit_location,
                            color: Colors.green,
                          );
                        default:
                          return Container();
                      }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                        print('_rating: ${_rating.toString()}');
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _notestTextController,
                    decoration:
                        buildInputDecoration(label: 'Your thoughts', hintText: 'Enter notes'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TwoSidedRoundeButton(
                      text: 'Update',
                      radius: 12,
                      color: kIconColor,
                      press: () {
                        print('widget.book.id: ${widget.book.id.toString()}');

                        // Only update if new data was entered
                        final userChangedTitle =
                            widget.book.title != _titleTextController!.text;
                        final userChangedAuthor =
                            widget.book.author != _authorTextController!.text;
                        final userChangedPhotoUrl =
                            widget.book.photoUrl != _photoTextController!.text;

                        final userChangedRating = widget.book.rating != _rating;

                        final userChangedNotes =
                            widget.book.notes != _notestTextController!.text;

//                        print('userChangedTitle: ${userChangedTitle.toString()}');
//                        print('userChangedAuthor: ${userChangedAuthor.toString()}');
//                        print('userChangedRating: ${userChangedRating.toString()}');
//                        print('${widget.book.rating.toString()}, ${_rating.toString()}');
//                        print('userChangedPhotoUrl: ${userChangedPhotoUrl.toString()}');
//                        print('userChangedNotes: ${userChangedNotes.toString()}');

                        final bookUpdate = userChangedTitle ||
                            userChangedAuthor ||
                            userChangedRating ||
                            userChangedPhotoUrl ||
                            userChangedNotes;

                        if (bookUpdate) {
                          print('(bookUpdate)widget.book.id: ${widget.book.id.toString()}');
                          _bookCollectionReference
                              .doc(widget.book.id)
                              .update(Book(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            title: _titleTextController!.text,
                            author: _authorTextController!.text,
                            photoUrl: _photoTextController!.text,
                            rating: _rating == null
                                ? widget.book.rating
                                : _rating,
                            startedReading: isReadingClicked
                                ? Timestamp.now()
                                : widget.book.startedReading,
                            finishedReading: isFinishedReadingClicked
                                ? Timestamp.now()
                                : widget.book.finishedReading,
                            notes: _notestTextController!.text,
                          ).toMap());

                        }

                        Navigator.of(context).pop();
                      },
                    ),
                    TwoSidedRoundeButton(
                      text: 'Delete',
                      radius: 12,
                      color: Colors.red,
                      press: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are you sure?'),
                              content:
                                  Text('Once the book is deleted you can\'t retrieve it back.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      _bookCollectionReference.doc(widget.book.id).delete();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreenPage(),
                                          ));
                                    },
                                    child: Text('Yes')),
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop(), child: Text('No'))
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
