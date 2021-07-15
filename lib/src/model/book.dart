//import 'package:book_tracker/constants/constants.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_web_book_tracker/src/constants/constants.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String notes;
//  final String photoUrl;
  final String categories;
//  final String publishedDate;
//  final double rating;
  final String description;
//  final int pageCount;
//  final Timestamp startedReading;
//  final Timestamp finishedReading;
//  final String userId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.notes,
//    required this.photoUrl,
    required this.categories,
//    required this.publishedDate,
//    required this.rating,
    required this.description,
//    required this.pageCount,
//    required this.startedReading,
//    required this.finishedReading,
//    required this.userId,
  });

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
        id: data['id'],
        title: data['title']!,
        author: data['author']!,
        notes: data['notes']!,
        categories: data['categories']!,
        description: data['description'],
    );
  }

//  factory Book.fromDocument(QueryDocumentSnapshot data) {
////    Map<String, dynamic> info = data.data();
//    Map<String, dynamic> info = data.data() as Map<String, dynamic>;
//    return Book(
//        id: data.id,
//        title: info['title']!,
//        author: info['author']!,
//        notes: info['notes']!,
//        photoUrl: info['photo_url']!,
//        categories: info['categories']!,
//        publishedDate: info['published_date']!,
//        rating: parseDouble(info['rating']!),
//        // rating: (info['rating'] as num) as double,
//        description: info['description']!,
//        pageCount: info['page_count']!,
//        startedReading: info['started_reading_at']!,
//        finishedReading: info['finished_reading_at']!,
//        userId: info['user_id']!);
//  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
//      'user_id': userId,
      'author': author,
      'notes': notes,
//      'photo_url': photoUrl,
//      'published_date': publishedDate,
//      'rating': rating,
      'description': description,
//      'page_count': pageCount,
//      'started_reading_at': startedReading,
//      'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
