import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'jsonclass.dart';

class DatabaseHandler {
  static var database;
  static initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Function to open the database file and store a reference.
    database = openDatabase(
      /* Set the path to the database. Using the `join` function from the
       `path` package  sets the correct path for each platform.
       */
      join(await getDatabasesPath(), 'jsons_database.db'),
      // When the database is first created, create a table to store books.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.

        db.execute(
          'CREATE TABLE jsons(id INTEGER PRIMARY KEY,version INTEGER, json_data TEXT)',
        );
        db.execute(
          // 'CREATE TABLE shopping_cart(id INTEGER PRIMARY KEY AUTOINCREMENT,version INTEGER, json_data TEXT)',
          'CREATE TABLE shopping_cart(description TEXT, name TEXT, price TEXT, image TEXT )',
        );

        db.execute(
          // 'CREATE TABLE order(id INTEGER PRIMARY KEY AUTOINCREMENT,version INTEGER, json_data TEXT)',
          'CREATE TABLE product_order(description TEXT, name TEXT, price TEXT, image TEXT )',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    print("Attach data in the data base");
    print(database);
  }

  // Define a function that inserts books into the database
  static Future<void> insertJson(Json json) async {
    // Get a reference to the database.
    final db = await database;
    print("Come in the insert function");
    /* Insert the book into the correct table. You might also specify the
     `conflictAlgorithm` to use in case the same book is inserted twice. This cn therefore be used
     for update as well. Other values are abort,ignore,fail and rollback


     In this case, replace any previous data.*/
    await db.insert(
      'jsons',
      json.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertShopping_card(Shopping shop) async {
    // Get a reference to the database.
    final db = await database;
    print("Come in the insert function");
    /* Insert the book into the correct table. You might also specify the
     `conflictAlgorithm` to use in case the same book is inserted twice. This cn therefore be used
     for update as well. Other values are abort,ignore,fail and rollback


     In this case, replace any previous data.*/

    await db.insert(
      'shopping_cart',
      shop.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert Product Order
  static Future<void> insertOrder(Order_Detail order) async {
    // Get a reference to the database.
    final db = await database;
    print("Come in the insert function");
    /* Insert the book into the correct table. You might also specify the
     `conflictAlgorithm` to use in case the same book is inserted twice. This cn therefore be used
     for update as well. Other values are abort,ignore,fail and rollback


     In this case, replace any previous data.*/

    await db.insert(
      'product_order',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the details from the json table.
  static Future<List<Json>> jsons() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The books.
    final List<Map<String, dynamic>> maps = await db.query('jsons');

    // Convert the List<Map<String, dynamic> into a List<Book>.
    return List.generate(maps.length, (i) {
      return Json(
        maps[i]['id'],
        maps[i]['version'],
        maps[i]['json_data'],
      );
    });
  }

  // A method that retrieves all the details from the Shopping table.

  static Future<List<Shopping>> cards() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The books.
    final List<Map<String, dynamic>> maps = await db.query('shopping_cart');
    //  await db.rawQuery('SELECT card_data FROM shopping_cart');
    // await db.query('SELECT card_data FROM shopping_cart');
    print(maps);

    // Convert the List<Map<String, dynamic> into a List<Book>.
    return List.generate(maps.length, (i) {
      return Shopping(
        maps[i]['description'],
        maps[i]['name'],
        maps[i]['price'],
        maps[i]['image'],
      );
    });
  }

  // A method that retrieves all the details from the Order table.

  static Future<List<Order_Detail>> orders() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The books.
    final List<Map<String, dynamic>> maps = await db.query('product_order');

    print(maps);

    // Convert the List<Map<String, dynamic> into a List<Book>.
    return List.generate(maps.length, (i) {
      return Order_Detail(
        maps[i]['description'],
        maps[i]['name'],
        maps[i]['price'],
        maps[i]['image'],
      );
    });
  }

  static Future<void> updateJson(Json json) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given book.
    await db.update(
      'jsons',
      json.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      // Ensure that the book has a matching id.
      where: 'id = ?',
      // Pass the book's id as a whereArg to prevent SQL injection.
      whereArgs: [json.id],
    );
  }

  // Delete product by name
  static Future<void> deleteOrderByName(String productName) async {
    if (database == null) {
      throw Exception("Database not initialized");
    }
    await database!.delete(
      'product_order',
      where: 'name = ?',
      whereArgs: [productName],
    );
  }

  static Future<void> deleteJson(String name) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the book from the database.
    await db.delete(
      'product_order',
      // Use a `where` clause to delete a specific book.
      where: 'name = ?',
      // Pass the book's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }

  static void printJson() async {
    // Create a book and add it to the books table

    // Now, use the method above to retrieve all the books.

    print(await DatabaseHandler.jsons()); // Prints a list that include book.

    // Update book's price and save it to the database.
    // Prints book with price 42.

    // Delete book from the database.
  }
}

// Convert a Book into a Map. The keys must correspond to the names of the
// columns in the database.
