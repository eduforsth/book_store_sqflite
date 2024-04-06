import 'package:book_store_db/helper/database_helper.dart';
import 'package:book_store_db/model/book.dart';
import 'package:book_store_db/second_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
        future: databaseHelper.getAllBooks(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book book = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            child: Text(book.bookName.substring(0, 2))),
                        title: Text(book.authorName),
                        subtitle: Text(book.price.toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.update_outlined),
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SecondScreen(
                                              book: Book.withId(
                                                  book.id,
                                                  book.bookName,
                                                  book.authorName,
                                                  book.price))));
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteDialog(book: book);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        });
  }

  void deleteDialog({required Book book}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are You Sure Want to Delete?'),
            content: Text(book.bookName),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              OutlinedButton(
                  onPressed: () {
                    databaseHelper.delete(book.id!);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }
}
