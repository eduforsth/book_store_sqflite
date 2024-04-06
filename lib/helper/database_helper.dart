import 'package:book_store_db/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  String databaseName = 'bookstore.db';
  String tableName = 'book';

  String column_id = 'id';
  String column_book_name = 'bookName';
  String column_author_name = 'authorName';
  String column_price = 'price';

  Future<Database> getDatabase() async {
    var dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, databaseName), onCreate: createDatabase, version: 1);
  }

  createDatabase(Database db, int version) {
    String sql =
        'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, $column_book_name CHAR, $column_author_name CHAR, price INTEGER)';
    db.execute(sql);
  }

//Add Book
  Future<int> insertDatabase(Book book) async {
    Database db = await getDatabase();
    return db.insert(tableName ,book.toMap());
  }

// Update Book
  Future<int> updateBook(Book book) async {
    Database db = await getDatabase();
    return db.update(tableName ,book.toMap(), where: '$column_id = ?', whereArgs: [book.id]);
  }

//get All Books List
  Future<List<Book>> getAllBooks() async{
 Database db = await getDatabase();
 List<Map<String, dynamic>> listMap = await db.query(tableName);
//  List<Book> listBook= [];
//  for(var lis in listMap){
//  listBook.add(Book.fromMap(lis));}
//  List<Book> listBook = listMap.map((e) => Book.fromMap(e)).toList();
List<Book> listBook = listMap.map((e) => Book.fromMap(e)).toList();
 return listBook;
  }

  Future<int> delete(int id) async{
    Database db = await getDatabase();
    int res = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return res;
  }


}
