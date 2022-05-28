import 'package:footwearclub/buyer/models/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';

final String tableWishList = 'wishlist';
final String id = 'id';
final String title = 'title';
final String price = 'price';
final String color = 'color';
final String stock = 'stock';
final String imgurl = 'imgurl';
final String sellerid = 'sellerid';
final String productid = 'productid';
final String subtype = 'subtype';
final String category = 'category';
//  late final Map<String, dynamic> productdatalist;
// final String wishlistmap = "wishlistmap";

class WishListHelper {
  static Database? _database;
  static WishListHelper? _wishListHelper;

  WishListHelper._createInstance();
  factory WishListHelper() {
    if (_wishListHelper == null) {
      _wishListHelper = WishListHelper._createInstance();
    }
    return _wishListHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "wishlist.db";
    print("path");
    print(path);

    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          create table $tableWishList ( 
          $id integer primary key autoincrement, 
          $title text not null,
          $price text,
          $color text,
          $stock text,
          $imgurl text,
          $sellerid text,
          $productid text,
          $subtype text,
          $category text)
        ''');
      },
    );
    return database;
  }

  Future insertData(WishListModel wishListModel) async {
    var db = await this.database;
    var result = await db!.insert(tableWishList, wishListModel.toMap());
    print('result : $result');
    // var id = await result;
  }

  Future<List<WishListModel>> getWishList() async {
    List<WishListModel> mywishlist = [];
    var db = await this.database;
    var result = await db!.query(tableWishList);
    result.forEach((element) {
      // print("element $element");
      var wishListModel = WishListModel.fromMap(element);
      mywishlist.add(wishListModel);
    });
    // print(mywishlist);
    return mywishlist;
  }

  Future<int> deleteWishList(int id) async {
    var db = await database;
    return await db!.delete(tableWishList, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteproductWishList(String pid) async {
    var db = await database;
    // db!.rawDelete("DELETE FROM Tasks WHERE id = $pid");
    return await db!.delete(tableWishList, where: 'productid = ?', whereArgs: [pid]);
  }
}
