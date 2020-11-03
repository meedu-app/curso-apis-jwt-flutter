import 'package:meta/meta.dart' show required;

class HttpResponse<T> {
  final T data;
  final HttpError error;

  HttpResponse(this.data, this.error);

  static HttpResponse<T> success<T>(T data) => HttpResponse(data, null);

  static HttpResponse<T> fail<T>({
    @required int statusCode,
    @required String message,
    @required dynamic data,
  }) =>
      HttpResponse(
        null,
        HttpError(
          statusCode: statusCode,
          message: message,
          data: data,
        ),
      );
}

class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({
    @required this.statusCode,
    @required this.message,
    @required this.data,
  });
}
