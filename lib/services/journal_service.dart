import 'dart:convert';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import '../models/journal.dart';

class JournalService {
  static const String url = "http://192.168.8.101:3000/";
  static const String resource = "journals/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  //unindo as variaveis acima
  String getUrl() {
    return "$url$resource";
  }

  //registrando no banco
  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response =
        await client.post(
            Uri.parse(getUrl()),
            headers: {
              'Content-Type': 'application/json'
            },
            body: jsonJournal);


    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  //lendo do banco
  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}
