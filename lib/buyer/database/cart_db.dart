import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:sqflite/sqflite.dart';

final String tableCart = 'cart';
final String id = 'id';
final String title = 'title';
final String price = 'price';
final String color = 'color';
final String stock = 'stock';
final String imgurl = 'imgurl';
final String sellerid = 'sellerid';
final String productid = 'productid';
final String category = 'category';
final String subtype = 'subtype';
final String size = 'size';
final String quantity = 'quantity';

//  late final Map<String, dynamic> productdatalist;
// final String wishlistmap = "wishlistmap";

class CartHelper {
  static Database? _database;
  static CartHelper? _cartHelper;

  CartHelper._createInstance();
  factory CartHelper() {
    if (_cartHelper == null) {
      _cartHelper = CartHelper._createInstance();
    }
    return _cartHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "cart.db";
    print(path);

    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          create table $tableCart ( 
          $id integer primary key autoincrement, 
          $title text not null,
          $price text,
          $color text,
          $stock text,
          $imgurl text,
          $sellerid text,
          $productid text,
          $category text,
          $subtype text,
          $size text,
          $quantity text
          )
        ''');
      },
    );
    return database;
  }

  Future<void> insertCart(CartModel cartModel) async {
    var db = await this.database;
    var result = await db!.insert(tableCart, cartModel.toMap());
    print('result : $result');
    // return result;
  }

  Future<List<CartModel>> getCartList() async {
    List<CartModel> mycartlist = [];
    var db = await this.database;
    var result = await db!.query(tableCart);
    result.forEach((element) {
      var cartModel = CartModel.fromMap(element);
      mycartlist.add(cartModel);
    });
    print(mycartlist);
    return mycartlist;
  }

  Future updateCartItem(int id, String qunatity) async {
    print(id);
    print(qunatity);
    var db = await database;
    int updateCount = await db!.rawUpdate(
        'UPDATE $tableCart SET quantity = ? WHERE id = ?', [qunatity, id]);

    print("updateCount $updateCount");
  }

  Future<int> deleteCartitem(int id) async {
    var db = await database;
    return await db!.delete(tableCart, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteTable() async {
    var db = await database;
    return await db!.delete(tableCart);
  }
}
