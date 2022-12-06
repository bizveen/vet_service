
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../../constants.dart';
import '../../../controllers/global_live_variables_controller.dart';
import '../../../models/sale/Product.dart';
import '../../../resources/firebase_database_methods.dart';
import '../add_new_product_screen.dart';

class SearchProductWidget extends StatefulWidget {
  String title;
  Function (Product) onSelect;
  SearchProductWidget({Key? key , required this.title , required this.onSelect}) : super(key: key);

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  TextEditingController searchController = TextEditingController();
  List<Product> listItems = [];
  Product? selectedValue;
  bool isUploading = false;
  String databasePath = '$doctorPath/products';
  @override
  void dispose() {

    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
        query: FirebaseDatabaseMethods().reference(path: databasePath),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return SizedBox(
                width: Get.width * 0.5,
                child: const LinearProgressIndicator());
          } else if (snapshot.hasData) {
            listItems.clear();
            for (final child in snapshot.docs) {
              listItems.add(Product.fromJson(child.value as Map<dynamic,dynamic>));
            }
          }
          return GFSearchBar<Product>(

            controller: searchController,
            searchList: listItems,
            searchBoxInputDecoration: InputDecoration(
              hintText:
              (selectedValue!= null ? selectedValue!.name :  widget.title).toTitleCase,
              hintStyle: const TextStyle(color: Colors.black),
              suffixIcon: const Icon(Icons.search),
            ),
            noItemsFoundWidget: Container(

                height: 50,
                child: Center(child: TextButton(child : Text('Add New Item') , onPressed: (){
                  Get.to(
                    AddNewProductScreen()
                  );
                },))),
            searchQueryBuilder: (query, list) {
              return filterMethod(query);
            },
            overlaySearchListItemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.name.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
            onItemSelected: (item) {
              setState(() {
                selectedValue = item;
              });

              widget.onSelect(item);
            },
          );
        });
  }

  List<Product> filterMethod(searchText) {
    List<Product> filteredList = [];
    List<Product> tempList = listItems;
    List<String> subWords = searchText.split(' ');
    for (int i = 0; i < subWords.length; i++) {
      tempList = tempList
          .where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(subWords[i].toLowerCase()))
          .toList();
      filteredList = tempList;
    }
    return filteredList.toSet().toList();
  }
}
