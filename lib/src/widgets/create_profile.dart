import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/model/user.dart';
import 'package:flutter_web_book_tracker/src/widgets/update_user_profile.dart';

Widget createProfileDialog(BuildContext context, MUser curUser) {
  final TextEditingController _displayNameTextController =
      TextEditingController(text: curUser.displayName);
  final TextEditingController _professionTextContorller =
      TextEditingController(text: curUser.profession);
  final TextEditingController _quoteTextController = TextEditingController(text: curUser.quote);
  final TextEditingController _avatarTextController =
      TextEditingController(text: curUser.avatarUrl);

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
                backgroundImage: NetworkImage(curUser.avatarUrl ?? 'https://i.pravatar.cc/300'),
                radius: 60,
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Text(
            'Books Reader',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.pinkAccent),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                child: Container(
//                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(curUser.displayName.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      print('upgradeProfileDialog');
                      return UpdateUserProfile(
                        user: curUser,
                        displayNameTextController: _displayNameTextController,
                        professionTextContorller: _professionTextContorller,
                        quoteTextController: _quoteTextController,
                        avatarTextController: _avatarTextController
                      );
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
                border: Border.all(width: 2, color: Colors.blueGrey.shade100),
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
                        curUser.quote == null ? ' "Favorite book quote: Life is great..." ' : '" ${curUser.quote}  "',
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
}

