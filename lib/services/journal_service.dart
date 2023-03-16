import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const String url = "http://192.168.8.101:3000/";
  static const String resource = "learninghttp/";

  http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  //unindo as variaveis acima
  String getUrl(){
    return "$url$resource";
  }

  //registando no banco
  register(String content){
    client.post(Uri.parse(getUrl()), body: {
      "content": content
    });
  }

  //lendo do banco
  Future<String> get() async{
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }


}