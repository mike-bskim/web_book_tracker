//import 'package:book_tracker/constants/constants.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_web_book_tracker/src/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_web_book_tracker/src/constants/constants.dart';

class Book {
  final String? id;
  final String title;
  final String author;
  final String? notes;
  final String? photoUrl;
  final String? categories;
  final String? publishedDate;
  final double? rating;
  final String? description;
  final int? pageCount;
  final Timestamp? startedReading;
  final Timestamp? finishedReading;
  final String? userId;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.notes,
    this.photoUrl,
    this.categories,
    this.publishedDate,
    this.rating,
    this.description,
    this.pageCount,
    this.startedReading,
    this.finishedReading,
    this.userId,
  });

//  factory Book.fromMap(Map<String, dynamic> data) {
//    print('fromMap' + data.toString());
////    Map<String, dynamic> info = data.data();
//    return Book(
//      id: data['id'],
//      title: data['title']!,
//      author: data['author']!,
//      notes: data['notes']!,
//      photoUrl: data['photoUrl']!,
//      categories: data['categories']!,
//      publishedDate: data['publishedDate']!,
//      rating: data['rating']!,
//      description: data['description'],
//      pageCount: data['pageCount']!,
//      userId: data['user_id']!,
//    );
//  }

  factory Book.fromDocument(QueryDocumentSnapshot data) {
//    Map<String, dynamic> info = data.data();
    Map<String, dynamic> info = data.data() as Map<String, dynamic>;
    return Book(
        id: data.id,
        title: info['title']!,
        author: info['author']!,
        notes: info['notes'],
        photoUrl: info['photo_url'],
        categories: info['categories'],
        publishedDate: info['published_date'],
        rating: parseDouble(info['rating']),
//         rating: (info['rating'] as num) as double,
        description: info['description'],
        pageCount: info['page_count'],
        startedReading: info['started_reading_at'],
        finishedReading: info['finished_reading_at'],
        userId: info['user_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userId,
      'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      'rating': rating,
      'description': description,
      'page_count': pageCount,
      'started_reading_at': startedReading,
      'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
