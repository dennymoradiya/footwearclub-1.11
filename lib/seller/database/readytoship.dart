import 'package:footwearclub/seller/models/readytoship_model.dart';
import 'package:sqflite/sqflite.dart';

final String tableReadyToShip = 'readytoship';
final String id = 'id';
final String orderid = 'orderid';
final String title = 'title';
final String quantity = 'quantity';
final String price = 'price';
final String totalamt = 'totalamt';
final String size = 'size';
final String imgurl = 'imgurl';
final String date = 'date';
final String buyername = 'buyername';
final String buyeraddress = 'buyeraddress';
final String buyerphone = 'buyerphone';

class ReadyToShipHelper {
  static Database? _database;
  static ReadyToShipHelper? _readytoshipHelper;

  ReadyToShipHelper._createInstance();
  factory ReadyToShipHelper() {
    if (_readytoshipHelper == null) {
      _readytoshipHelper = ReadyToShipHelper._createInstance();
    }
    return _readytoshipHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database?> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "readytoship.db";
    print("init db call");
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        try {
          db.execute('''
          create table $tableReadyToShip ( 
          $id integer primary key autoincrement, 
          $orderid text not null,
          $title text not null,
          $quantity text,
          $price text,
          $totalamt text,
          $size text,
          $imgurl text,
          $date text,          
          $buyername text,          
          $buyeraddress text,          
          $buyerphone text  
          )
        ''');
        } catch (e) {
          print("database error");
          print(e);
          return null;
        }
      },
    );
    return database;
  }

  void insertData(ReadyToShipModel readyToShipModel) async {
    var db = await this.database;
    var result = await db!.insert(tableReadyToShip, readyToShipModel.toMap());
    // print('result : $result');
  }

  Future<List<ReadyToShipModel>> getReadytoshipList() async {
    List<ReadyToShipModel> readytoshipList = [];
    var db = await this.database;
    var result = await db!.query(tableReadyToShip);
    result.forEach((element) {
      // print("element $element");
      var readyToShipModel = ReadyToShipModel.fromMap(element);
      readytoshipList.add(readyToShipModel);
    });

    return readytoshipList;
  }

  Future<int> deleteData(int id) async {
    var db = await this.database;
    return await db!
        .delete(tableReadyToShip, where: '$id = ?', whereArgs: [id]);
  }

  Future deleteTable() async {
    var db = await this.database;
    return await db!.delete(tableReadyToShip);
  }
}
