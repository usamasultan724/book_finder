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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors?.join(','),
      'thumbnail': thumbnail,
    };
  }

}


class FavoriteBook {
  final String id;
  final String? title;
  final String? authors; 
  final String? thumbnail;

  FavoriteBook({
    required this.id,
    this.title,
    this.authors,
    this.thumbnail,
  });

  factory FavoriteBook.fromJson(Map<String, dynamic> json) {
    return FavoriteBook(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString(),
      authors: json['authors']?.toString(), 
      thumbnail: json['thumbnail']?.toString(),
    );
  }
}
