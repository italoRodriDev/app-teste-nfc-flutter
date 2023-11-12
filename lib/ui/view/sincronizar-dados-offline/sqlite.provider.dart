import 'package:sqflite/sqflite.dart';

class SqliteApi {
  static const _nameDB = 'app-testes';

  // Criando tabelas
  static Future<void> openDatabaseApp() async {
    await openDatabase(
      _nameDB,
      version: 1,
      onCreate: (Database db, int version) async {
        // Deletes the Auth table if it exists
        if (db.isOpen) {
          await db.execute('DROP TABLE IF EXISTS User;');
        }

        // Criando tabela usuario
        await db.execute(
            '''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY,
            nome TEXT
            );
        ''');
      },
    );
  }

  // Inserindo dados do usuario
  static Future<void> insertDataUser(nome) async {
    final db = await openDatabase(_nameDB);

    await db.transaction((txn) async {
      await txn.rawInsert(
          '''
        INSERT INTO User(
          nome
        )
        VALUES(?);
      ''',
          [nome]);
    });

    await updateDataUser(nome);
  }

  // Atualizando dados do usuario
  static Future<void> updateDataUser(nome) async {
    final db = await openDatabase(_nameDB);

    final List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM User;');

    if (list.isNotEmpty) {
      await db.rawUpdate(
          '''
        UPDATE User
        SET 
            nome = ?
        WHERE id = 1;
      ''',
          [nome]);
    }
  }

  // Recuperando dados do usuario
  static Future<dynamic> getDataUser() async {
    final db = await openDatabase(_nameDB);
    final List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM User;');
    String nome = '';

    if (list.isNotEmpty) {
      final Map<String, dynamic> data = list[0];

      nome = data['nome'].toString();
    }

    return nome;
  }

  // Remover authorization
  static Future<void> deleteDataUser() async {
    final db = await openDatabase(_nameDB);

    try {
      await db.transaction((txn) async {
        await txn.rawDelete('DELETE FROM User;');
      });
    } catch (e) {}
  }
}
