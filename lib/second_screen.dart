// import 'dart:js_interop';

import 'package:book_store_db/helper/database_helper.dart';
import 'package:book_store_db/model/book.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  Book? book; // Book.withId(....);
  SecondScreen({super.key, this.book});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late TextEditingController _nameController;
  late TextEditingController _authorController;
  late TextEditingController _priceController;

  DatabaseHelper databaseHelper = DatabaseHelper();
Book? wBook;
  @override
  void initState() {
     wBook = widget.book;
    _nameController = TextEditingController(text: wBook?.bookName);
    _authorController = TextEditingController(text: wBook?.authorName);
    _priceController = TextEditingController(text: wBook?.price.toString());

    //
    // _nameController.text = wBook!.bookName;
    // _authorController.text = wBook!.authorName;
    // _priceController.text = wBook!.price.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              wBook == null ? const Text('Save Book') : const Text('Edit Book')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextField(
                // autofocus: wBook == null ? false : true,
                controller: _nameController,
                decoration: const InputDecoration(
                    label: Text('Book Name'),
                    border: OutlineInputBorder(),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(
                  label: Text('Author Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Price'),
                    border: OutlineInputBorder(),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Book book = Book(
                        _nameController.text,
                        _authorController.text,
                        int.parse(_priceController.text));
                     int result = 0;
                        if(widget.book == null){
                     result = await databaseHelper.insertDatabase(book);
                        }else{
                         result = await databaseHelper.updateBook(Book.withId(wBook!.id, _nameController.text, _authorController.text, int.parse(_priceController.text)));
                        }
                        
                    if (result > 0) {
                      //  print('Success');
                      Navigator.pop(context);
                    } else {
                      //  print('Fail');
                    }
                  },
                  child: widget.book == null? const Text('Save') : const Text('Edit'))
            ]),
          ),
        ),
      ),
    );
  }
}
