// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.codeocean.net';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<UserModel>> fetchData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json'};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;

    Response<String> _result = await _dio.fetch<String>(
      _setStreamType<String>(
        Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
          contentType: 'application/json',
        )
            .compose(
              _dio.options,
              '/codeocean/getdata.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    // Dönüştürülen JSON dizesini JSON nesnesine dönüştür
    final dynamic jsonData = json.decode(_result.data ?? '');

    // JSON nesnesini User Model listesine dönüştür
    final List<UserModel> value =
        (jsonData as List<dynamic>).map((dynamic i) => UserModel.fromJson(i as Map<String, dynamic>)).toList();

    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
