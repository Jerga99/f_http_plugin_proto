import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'interceptor.dart';
import 'base_interceptor.dart';
import 'base_config.dart';
import 'config.dart';

class HttpService {
   final _client = http.Client();
   String _baseURL = '';
   Config _config = BaseConfig();
   Interceptor interceptors = BaseInterceptor();

  HttpService.create(Map<String, dynamic> options) {
    _configure(options);
  }

  void _applyHeaders(Map<String, String> headers) {
    if (headers != null) {
        headers.forEach((String key, String value) {
        _config.headers[key] = value;
      });
    }
  }

  String _buildUrl(url) {
    if (_baseURL.length > 0) {
      return _baseURL + url;
    }

    return url;
  }

  _configure(Map<String, dynamic> options) {
    if (options != null) {
      _baseURL = options['baseURL'] ?? '';
    }
  }

  _resetConfig() {
    _config = new BaseConfig();
  }

  _setup(headers) async {
    _resetConfig();
    await interceptors.request.configure(_config);
    _applyHeaders(headers);
  }

  Future<Response> get(dynamic url, {Map<String, String> headers}) async {
    await _setup(headers);
    return _client.get(_buildUrl(url), headers: _config.headers);
  }

  Future<Response> post(dynamic url, {Map<String, String> headers, dynamic body}) async {
    await _setup(headers);
    return _client.post(_buildUrl(url), headers: _config.headers, body: body);
  }
}
