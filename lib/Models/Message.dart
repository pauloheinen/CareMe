class Message {
  String author;
  String message;
  DateTime dateTime;

  Message(
      {required this.author, required this.message, required this.dateTime});

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'message': message,
      'datetime': dateTime,
    };
  }

  // factory Message.fromDocument(DocumentSnapshot documentSnapshot) {
  //   String author = documentSnapshot.get('author');
  //   String message = documentSnapshot.get('message');
  //   Timestamp timestamp = documentSnapshot.get('timestamp');
  //
  //   return Message(author: author, message: message, timestamp: timestamp);
  // }
}
