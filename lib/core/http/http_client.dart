abstract class HttpClient {
  Future<HttpResponse> get({required String url});
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;

  const HttpResponse({required this.data, required this.statusCode});
}