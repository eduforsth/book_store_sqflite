import 'package:book_store_db/body.dart';
import 'package:book_store_db/helper/database_helper.dart';
import 'package:book_store_db/model/book.dart';
import 'package:book_store_db/search_data.dart';
import 'package:book_store_db/second_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Book> bookList = [];
  List<String> list = [];
  void getList() async {
    list.clear();
    bookList.clear();
    var bl = await databaseHelper.getAllBooks();
    bookList.addAll(bl);
    for (int i = 0; i < bookList.length; i++) {
      list.add(bookList[i].bookName);
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        actions: [
          IconButton(
              onPressed: () {
                getList();
                showSearch(context: context, delegate: SearchData(bookList, list));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigation
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SecondScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

