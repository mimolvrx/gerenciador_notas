// Este arquivo é responsável por definir o formato de cada anotação.

// Classe não desenha tela, nem salva dados.
class Nota {
  final String id;
  final String titulo;
  final String conteudo;

  // o construtor recebe os valores ao criar a nora
  // required obriga o usuario a informar o parametro nomeado
  // this.id atribui o parametro ao atributo id do objeto
  const Nota({
    required this.id,
    required this.titulo,
    required this.conteudo
  });

  // Map relaciona cada chave string ao seu valor.
  // dynamic permite valores de diferentes tipo no mapa.
  // Converter para Map facilita transformar o objeto em json
  Map<String, dynamic> toMap() {
    return {
      'id' : id, // chave 'id' recebe o atributo id. (chave e valor)
      'titulo' : titulo,
      'conteudo' : conteudo,
    };
  }

  // factory permite criar uma nota usando dados já existentes
  // map['id'] lê o valor associado a chave 'id'
  // as String informa que estamos esperando um texto nesse campo.
  factory Nota.fromMap(Map <String, dynamic> map) {
    return Nota (
      id: map['id'] as String,
      titulo: map['titulo'] as String,
      conteudo: map['conteudo'] as String,
    );
  }
}