import 'dart:convert';

import 'package:gerenciador_notas/models/nota.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Serviço: separa as regras de armazenamento dos widgets da tela.
class NotaStorageService {
  // a chave funciona como o nome do espaço onde guardamos o texto
  // chave antiga guardava apenas uma nota
  static const String chaveAntiga = 'nota_inicial';
  // chave que identifica a lista no armazenamento local
  static const String chaveNota = 'lista_notas';

  // SharedPreferenceAsync lê e grava valores simples no dispositivo.
  // final impede _perfs receba outra instancia depois de criada
  final SharedPreferencesAsync _perfs = SharedPreferencesAsync();

  // Future<List<Nota>> indica que no futuro virá uma lista.
  // async permite que use await durante a leitura do dispositivo
  Future<List<Nota>> listarNotas() async {
    // permitir o texto ou null.
    final String? texto = await _perfs.getString(chaveNota);

    // se não há lista salva, verificamos a nota da aula 1
    if( texto == null) {
      final String? antiga = await _perfs.getString(chaveAntiga);

      // tratando lista null ou com espaço, 
      if(antiga == null || antiga.trim().isEmpty) {
        return []; // pode retornar lista vazia caso esteja null
      }

      // transformando a anotação antiga em uma nota completa
      final Nota primeira = Nota (
        // horario em microssegundos gerar um identificador simpls
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        titulo: 'Minha primeira nota',
        conteudo: antiga
      );

      // salvar a nota no formato novo e remover a chave antiga
      await salvarLista([primeira]);
      await _perfs.remove(chaveAntiga);
      return [primeira]; // devolcemos a nota convertida
    }

    // JsonDecode transforma o texto em json em estruturas dart.
    // List<dynamic> informa ue esperamos uma lista
    final List<dynamic> dados = jsonDecode(texto) as List<dynamic>;

    // map() percorre cada elemento e transformar em nota
    // .toList() materializa o resultado como lista dart.
    return dados.map((item){
      return Nota.fromMap(item as Map<String, dynamic>);
    }).toList();
  }

  // Recebe a lista completa e grava a sua versão atualizada
  Future<void> salvarLista(List<Nota> notas) async {
    // convertendo cada objeto Nota para Map com o toMap()
    final List<Map<String, dynamic>> dados = notas.map((nota)
    {
      return nota.toMap();
    }).toList();

    // JsonEncode transformamos a lista de maps em texto json
    final String texto = jsonEncode(dados);
    // await aguarda a conclusão d gravação no dispositivo
    await _perfs.setString(chaveNota, texto);
  }

  // acrescenta uma nova nota sem apagar os registros anteriores
  Future<void> adicionarNota(Nota novaNota) async{
    // primeiro recuperamos tudo que estava salvo
    final List<Nota> notas = await listarNotas();
    // insere a nova nota no fim da lista
    notas.add(novaNota);
    // grava a lista inteira novamente
    await salvarLista(notas);
  }


}