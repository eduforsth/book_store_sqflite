import 'package:book_store_db/model/book.dart';
import 'package:flutter/material.dart';

class SearchData extends SearchDelegate{
  List<Book> list;
  List<String> suList;
  SearchData(this.list, this.suList);

  @override
  List<Widget>? buildActions(BuildContext context) {
return [
    IconButton(onPressed: (){
      query = '';
    }, icon: const Icon(Icons.close),)
];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: const Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> resutlList = list.where((element) => element.bookName.toLowerCase().contains(query.toLowerCase())).toList();
    return resutlList.isEmpty
    ? const Center(child: Text('No Data Found'),)
    : ListView.builder(
            itemCount: resutlList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(resutlList[index].bookName.substring(0, 2))),
                  title: Text(resutlList[index].bookName),
                  subtitle: Text(resutlList[index].bookName),
                  trailing: Text(resutlList[index].price.toString()),
                ),
              );
            });
    // return const Text('Result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> resutSulList = suList.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
  
    return resutSulList.isEmpty
    ? const Center(child: Text('No Data Found'),)
    : ListView.builder(
            itemCount: resutSulList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(resutSulList[index]),
                ),
              );
            });
    // return const Text('Suggestion');
  }
  
}