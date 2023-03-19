import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJournalScreen extends StatelessWidget {
  //instanciando as entradas de diario
  final Journal journal;
  final bool isEditing;

  AddJournalScreen({Key? key, required this.journal, required this.isEditing})
      : super(key: key);

  //controlador para pegar as informacoes
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(journal.createdAt).toString()),
        actions: [
          IconButton(
              onPressed: () {
                registerJournal(context);
              },
              icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }

  //registrando conteudo no db
  registerJournal(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString("accessToken");
      if (token != null) {
        //informacao do o corpo na variavel local
        String content = _contentController.text;

        //mudar o primeiro journal para o conteudo atualizado de cima
        journal.content = content;

        //chamando o service
        JournalService service = JournalService();

        if (isEditing) {
          service.register(journal, token).then((value) {
            //voltar para a tela inicial
            //fazer um snackbar (pegar o resultado boleano acima)
            Navigator.pop(context, value);
          });
        } else {
          service.edit(journal.id, journal, token).then((value) {
            //voltar para a tela inicial
            //fazer um snackbar (pegar o resultado boleano acima)
            Navigator.pop(context, value);
          });
        }
      }
    });
  }
}
