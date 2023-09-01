// ignore_for_file: constant_identifier_names

class Resource<T> {
  Status status;
  T? data;
  String? errorMessage;
  int? statusCode;

  Resource({required this.status, required this.data, required this.errorMessage, this.statusCode});

  static Resource<T> success<T>(T data) {
    return Resource(status: Status.SUCCESS, data: data, errorMessage: null);
  }

  static Resource<T> error<T>(String message, int? statusCode) {
    return Resource(status: Status.ERROR, data: null, errorMessage: message, statusCode: statusCode);
  }
}

enum Status {
  SUCCESS,
  ERROR,
}
