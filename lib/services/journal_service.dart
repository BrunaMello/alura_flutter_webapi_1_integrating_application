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
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-Type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  //lendo o banco edit
  Future<bool> edit(String id, Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());

    http.Response response = await client.put(
      Uri.parse("${getUrl()}$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  //lendo do banco get
  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));

    //se der errado o codigo para aqui
    if (response.statusCode != 200) {
      throw Exception();
    }

    //fazer uma lista vazia para preencher
    List<Journal> list = [];

    //preenchendo a lista com os items abaixo
    List<dynamic> listDynamic =
        json.decode(response.body); //json ja retorna a lista automatico

    //transformando em journal (usando o converter que esta no model)
    for (var jsonMap in listDynamic) {
      list.add(Journal.fromMap(jsonMap));
    }

    return list;
  }

  Future<bool> delete(String id) async {
    http.Response response = await http.delete(Uri.parse("${getUrl()}$id"));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
