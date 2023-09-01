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
  Future<List<UserModel>> getData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json'};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    Response<String> _result = await _dio.fetch<String>(_setStreamType<List<UserModel>>(Options(
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
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final dynamic jsonData = json.decode(_result.data ?? '');

    // JSON nesnesini User Model listesine dönüştür
    final List<UserModel> value =
        (jsonData as List<dynamic>).map((dynamic i) => UserModel.fromJson(i as Map<String, dynamic>)).toList();

    return value;
  }

  @override
  Future<Resource<UserModel>> signup(Map<String, dynamic> user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(user);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/register.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );

      // Dönüştürülen JSON dizesini JSON nesnesine dönüştür
      final dynamic jsonData = json.decode(_result.data ?? '');

      // JSON nesnesini User Model'e dönüştür
      final UserModel value = UserModel.fromJson(jsonData as Map<String, dynamic>);
      return Resource.success(value);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          return Resource.error(
              e.response?.statusMessage ?? 'hint: This mail address already in use ', e.response?.statusCode);
        } else if (e.response?.statusCode == 500) {
          return Resource.error(
              e.response?.statusMessage ?? 'hint: Kullanici eklenirken bir hata oluştu', e.response?.statusCode);
        }
      }
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
  }

  @override
  Future<Resource<UserModel>> login(Map<String, dynamic> user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(user);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/login.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );
      // Dönüştürülen JSON dizesini JSON nesnesine dönüştür
      final dynamic jsonData = json.decode(_result.data ?? '');

      // JSON nesnesini User Model'e dönüştür
      final UserModel value = UserModel.fromJson(jsonData as Map<String, dynamic>);
      return Resource.success(value);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Resource.error('Email veya şifreniz hatalı', e.response?.statusCode);
        } else if (e.response?.statusCode == 400) {
          return Resource.error(e.response?.statusMessage ?? ' WRONG METHOD', e.response?.statusCode);
        } else if (e.response?.statusCode == 403) {
          return Resource.error(e.response?.statusMessage ?? ' ACCOUNT INACTIVE', e.response?.statusCode);
        }
      }
      // Hata durumunda boş bir UserModel döndürebilirsiniz veya isteğe göre yönetebilirsiniz.
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
  }

  @override
  Future<Resource<List<ServiceModel>>> getServices(Map<String, dynamic> user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(user);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/getservices.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );
      // Dönüştürülen JSON dizesini JSON nesnesine dönüştür
      final dynamic jsonData = json.decode(_result.data ?? '');

      // JSON nesnesini User Model'e dönüştür
      final List<ServiceModel> value =
          (jsonData as List<dynamic>).map((dynamic i) => ServiceModel.fromJson(i as Map<String, dynamic>)).toList();

      return Resource.success(value);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Resource.error(e.response?.statusMessage ?? 'UNAUTHORIZAİED', e.response?.statusCode);
        } else if (e.response?.statusCode == 400) {
          return Resource.error(
              json.decode(e.response!.data.toString())['message'] ?? ' WRONG METHOD', e.response?.statusCode);
        }
      }
      // Hata durumunda boş bir ServiceModel döndürebilirsiniz veya isteğe göre yönetebilirsiniz.
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
  }

  @override
  Future<Resource<bool>> changePassword(Map<String, dynamic> newPassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(newPassword);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/changepassword.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );

      return Resource.success(true);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 405) {
          return Resource.error(e.response?.statusMessage ?? 'Geçersiz istek metodu', e.response?.statusCode);
        } else if (e.response?.statusCode == 400) {
          return Resource.error(
              e.response?.statusMessage ?? ' Eksik veya hatalı veri gönderildi', e.response?.statusCode);
        }
      }
      // Hata durumunda boş bir ServiceModel döndürebilirsiniz veya isteğe göre yönetebilirsiniz.
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
  }

  @override
  Future<Resource<bool>> sendOtp(Map<String, dynamic> emailInfo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(emailInfo);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/sendotp.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );

      return Resource.success(true);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          return Resource.error(e.response?.statusMessage ?? 'Geçersiz istek metodu', e.response?.statusCode);
        } else if (e.response?.statusCode == 421) {
          return Resource.error(
              e.response?.statusMessage ?? 'E-posta gönderilirken bir hata oluştu', e.response?.statusCode);
        }
      }
      // Hata durumunda boş bir ServiceModel döndürebilirsiniz veya isteğe göre yönetebilirsiniz.
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
  }

  @override
  Future<Resource<bool>> validateOtp(Map<String, dynamic> emailInfo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': 'application/json', r'charset': 'utf-8'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(emailInfo);

    try {
      Response<String> _result = await _dio.fetch<String>(
        _setStreamType<String>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/codeocean/validateotp.php',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
        ),
      );

      return Resource.success(true);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          return Resource.error(e.response?.statusMessage ?? 'Geçersiz istek metodu', e.response?.statusCode);
        } else if (e.response?.statusCode == 404) {
          return Resource.error(e.response?.statusMessage ?? 'Kullanıcı bulunamadı', e.response?.statusCode);
        }
      }
      // Hata durumunda boş bir ServiceModel döndürebilirsiniz veya isteğe göre yönetebilirsiniz.
      return Resource.error('NOT DioException ERROR !!!!', null);
    }
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
