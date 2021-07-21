import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/constants/constants.dart';
import 'package:flutter_web_book_tracker/src/model/book.dart';
import 'package:flutter_web_book_tracker/src/widgets/book_rating.dart';
import 'package:flutter_web_book_tracker/src/widgets/two_sided_roundbutton.dart';

class ReadingListCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? author;
  final double? rating;
  final String? buttonText;
  final Book? book;
  final bool? isBookRad;
  final Function? pressDetails;
  final VoidCallback? pressRead; // Function

  const ReadingListCard(
      {Key? key,
        this.image,
        this.title,
        this.author,
        this.rating = 4.5,
        this.buttonText,
        this.book,
        this.isBookRad,
        this.pressDetails,
        this.pressRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 0),
      width: 202,
//      height: 280,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 33,
                          color: Colors.black54)// kShadowColor
                    ]),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: image != null ? Image.network(image!, width: 100, )
                : Center(child: Text('No image')
            ),
          ),
          Positioned(
              top: 34,
              right: 10,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  BookRating(score: (rating!))
                ],
              )
          ),
          Positioned(
              top: 170,
              child: Container(
//                color: Colors.amberAccent,
                height: 100,
                width: 202,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:  6, left: 12),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                            style: TextStyle(color: kBlackColor),
                            children: [
                              TextSpan(
                                  text: title !=null ? '$title\n' : 'No title',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: author !=null ? author : '',
                                  style: TextStyle(color: kLightBlackColor)),
                            ]),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text('Details'),
                        ),
                        Expanded(
                            child: TwoSidedRoundeButton(
                                text: buttonText!,
                                press: pressRead!,
                                color: kLightPurple)
                        ),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
