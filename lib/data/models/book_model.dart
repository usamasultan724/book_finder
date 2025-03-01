class BookModel {
  final String id;
  final String? title;
  final List<String>? authors;
  final String? thumbnail;

  BookModel({
    required this.id,
    this.title,
    this.authors,
    this.thumbnail,
  });

  // Convert JSON to BookModel
  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    return BookModel(
      id: json['id']?.toString() ?? '',
      title: volumeInfo['title']?.toString(),
      authors: (volumeInfo['authors'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      thumbnail: imageLinks['thumbnail']?.toString(),
    );
  }

  // Convert BookModel to SQLite-friendly format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors?.join(','), // Convert List<String>? to String?
      'thumbnail': thumbnail,
    };
  }

  // Convert SQLite row to BookModel
  factory BookModel.fromSQLite(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      authors: json['authors'] != null
          ? (json['authors'] as String).split(',') // Convert String back to List
          : null,
      thumbnail: json['thumbnail'],
    );
  }
}
