import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request: ');
    print(' method: ${data.method}');
    print(' url: ${data.url}');
    print(' headers: ${data.headers}');
    print(' body: ${data.body}');
    print(' ');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response: ');
    print(' status code: ${data.statusCode}');
    print(' headers: ${data.headers}');
    print(' body: ${data.body}');
    print(' ');
    return data;
  }
}

void findAll() async {
  var client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  var url = Uri.parse('http://localhost:8080/transactions');

  var response = await client.get(url);
}
