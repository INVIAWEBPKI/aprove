import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static createDatabase() async {
    await openDatabase('my_db.db');
  }

  static closeDatabase() async {
    var db = await openDatabase('my_db.db');
    await db.close();
  }

  static Future<Database> createNotification() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_db.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE notifications (id INTEGER PRIMARY KEY, body TEXT, title TEXT, link TEXT, screen TEXT, titulo TEXT)');
    });
    return database;
  }

  static Future<List<Map>> selectNotifications() async {
    Database database = await createNotification();
    List<Map> notifications =
        await database.rawQuery('SELECT * FROM notifications');
    return notifications;
  }

  static saveNotification(String body, String title, String link, String screen,
      String titulo) async {
    Database database = await createNotification();
    database.rawInsert(
        'INSERT INTO notifications (body, title, link, screen, titulo) VALUES (?, ?, ?, ?, ?)',
        [body, title, link, screen, titulo]);
  }

  static deleteNotifications() async {
    Database database = await createNotification();
    database.rawInsert('DELETE FROM notifications');
  }
}
