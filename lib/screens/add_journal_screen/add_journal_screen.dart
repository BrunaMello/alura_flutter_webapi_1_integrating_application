import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  //instanciando as entradas de diario
  final Journal journal;

  AddJournalScreen({Key? key, required this.journal}) : super(key: key);

  //controlador para pegar as informacoes
  final TextEditingController _contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${WeekDay(journal.createdAt.weekday).long.toLowerCase()}, ${journal.createdAt.day}  |   ${journal.createdAt.month}  |   ${journal.createdAt.year} "),
        actions: [
          IconButton(onPressed: (){
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
          style: const TextStyle(
            fontSize: 24
          ),
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }

  //registrando conteudo no db
  registerJournal(BuildContext context) async {
    //informacao do o corpo na variavel local
    String content = _contentController.text;

    //mudar o primeiro journal para o conteudo atualizado de cima
    journal.content = content;

    //chamando o service
    JournalService service = JournalService();
    bool result = await service.register(journal);

    //voltar para a tela inicial
    //fazer um snackbar (pegar o resultado boleano acima)
    Navigator.pop(context, result);
  }
}
