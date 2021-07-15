import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/model/user.dart';
import 'package:flutter_web_book_tracker/src/widgets/input_decoration.dart';

Widget createProfileDialog(BuildContext context, MUser curUser) {
  final TextEditingController _displayNameTextController = TextEditingController(text: curUser.displayName);
  final TextEditingController _professionTextContorller = TextEditingController(text: curUser.profession);
  final TextEditingController _quoteTextController = TextEditingController(text: curUser.quote);
  final TextEditingController _avatarTextController = TextEditingController(text: curUser.avatarUrl);

  return AlertDialog(
    content: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(curUser.avatarUrl ?? 'https://i.pravatar.cc/300'),
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
//                initialValue: null,
                controller: _displayNameTextController,
                decoration: buildInputDecoration(label: 'Your name', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
//                initialValue: curUser.profession ?? 'no',
                controller: _professionTextContorller,
                decoration: buildInputDecoration(label: 'Profession', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
//                initialValue: curUser.quote ?? 'no',
                controller: _quoteTextController,
                decoration: buildInputDecoration(label: 'Favorite quote', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
//                initialValue: curUser.avatarUrl ?? 'no',
                controller: _avatarTextController,
                decoration: buildInputDecoration(label: 'Avatar URL', hintText: ''),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//class CreateProfileDialog extends StatelessWidget {
//  const CreateProfileDialog({
//    Key? key,
//    required this.curUser,
//    required TextEditingController displayNameTextController,
//    required TextEditingController professionTextContorller,
//    required TextEditingController quoteTextController,
//    required TextEditingController avatarTextController,
//  })  : _displayNameTextController = displayNameTextController,
//        _professionTextContorller = professionTextContorller,
//        _quoteTextController = quoteTextController,
//        _avatarTextController = avatarTextController,
//        super(key: key);
//
//  final MUser curUser;
//  final TextEditingController _displayNameTextController;
//  final TextEditingController _professionTextContorller;
//  final TextEditingController _quoteTextController;
//  final TextEditingController _avatarTextController;
//
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      title: Center(
//        child: Text('Edit "${curUser.displayName}" '),
//      ),
//      content: Form(
//        child: SingleChildScrollView(
//          child: Column(
//            children: [
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: CircleAvatar(
//                  backgroundColor: Colors.transparent,
//                  backgroundImage: NetworkImage(curUser.avatarUrl ?? 'https://i.pravatar.cc/300'),
//                  radius: 50,
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: TextFormField(
//                  initialValue: curUser.displayName,
//                  controller: _displayNameTextController,
//                  decoration: buildInputDecoration(label: 'Your name', hintText: ''),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: TextFormField(
//                  initialValue: curUser.profession ?? 'no',
//                  controller: _professionTextContorller,
//                  decoration: buildInputDecoration(label: 'Profession', hintText: ''),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: TextFormField(
//                  initialValue: curUser.quote ?? 'no',
//                  controller: _quoteTextController,
//                  decoration: buildInputDecoration(label: 'Favorite quote', hintText: ''),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: TextFormField(
//                  initialValue: curUser.avatarUrl ?? 'no',
//                  controller: _avatarTextController,
//                  decoration: buildInputDecoration(label: 'Avatar URL', hintText: ''),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//      actions: [
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: TextButton(onPressed: () {}, child: Text('Update')),
//        ),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: TextButton(
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: Text('Cancel')),
//        ),
//      ],
//    );
//  }
//}
