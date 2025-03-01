class ApiConstants {
  static const String baseUrl = 'https://www.googleapis.com/books/v1';
  static const String volumesEndpoint = '/volumes';

  static String searchBooks(String query) =>
      '$baseUrl$volumesEndpoint?q=$query';
}
