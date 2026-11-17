import 'package:shared_preferences/shared_preferences.dart';

// Serviço: separa as regras de armazenamento dos widgets da tela.
class NotaStorageService {
  // a chave funciona como o nome do espaço onde guardamos o texto
  static const String chaveNota = 'nota_inicial';

  // SharedPreferenceAsync lê e grava valores simples no dispositivo.
  // final impede _perfs receba outra instancia depois de criada
  final SharedPreferencesAsync _perfs = SharedPreferencesAsync();

  // Recebe o texto e o armazena, não devolve resultado
  Future<void> salvarNota(String texto) async {
    // setString associa a String a chave escolhida
    await _perfs.setString(chaveNota, texto);
  }

  // Recuperar a nota. Retorna String, mesmo se não existir valor.
  Future<String> buscarNota() async {
    // String? significa que podemos ter retorno com string null
    final String? nota = await _perfs.getString(chaveNota);
    // ?? usamos o texto vazio caso a nota seja null.
    return nota ?? '';
  }

  // Exclui somente o valor salvo na chave nota.
  Future<void> apagarNota() async {
    await _perfs.remove(chaveNota);
  }
}