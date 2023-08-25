import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{
   static Database? db ;

   Future<Database?> get data async{  //علشان الداتا بيتعملها انشيال مره واحده
      if(db== null){
        db =await intialDb();
        }
        return db;
   }


   
  Future<Database?>intialDb() async{
    var  databasePath = await getDatabasesPath();
    String path =await join(databasePath,"omar.db");// databadepath/omar
    Database mydb =await openDatabase(
      path , onCreate: oncreat,version: 1,onUpgrade: onUpgrade);
       
    return mydb;
    
  }
  onUpgrade(Database db, int oldVersion,int newVersion)async
  { 
    await db.execute("ALTER TABLE notec ADD title TEXT NOT NULL");
    
  }
  oncreat(Database db,int version) async{
  // Batch batch =db.batch();
   
   await db.execute('''
      CREATE TABLE notec (
      id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
      note TEXT NOT NULL ,
      title TEXT NOT NULL ,
      time DATE NOT NULL
      )
''');

  }
  Future<List<Map<String,dynamic>>> readData(String sql) async{
    Database? mydb =await data;
    List<Map<String,dynamic>> response =await mydb!.rawQuery(sql);
    return response;
  }
  Future<int> insertData(String sql) async{
    Database? mydb =await data;
     if (mydb != null) {
     try {
        int  response =await mydb.rawInsert(sql);//قيمة الرو 
         return response;
       }   catch (e) {
          print(e);
          return 0;
        }}else {
    print("Error: Database is null.");
    return 0;
  }  
  }
  Future<int> updateData(String selectSql) async{
    Database? mydb =await data;
    int response =await mydb!.rawUpdate(selectSql);
    return response;
  }
  Future<int> deleteData(String selectSql) async{
    Database? mydb =await data;
    int response =await mydb!.rawDelete(selectSql);
    return response;
  }
  mydeleteDatabase()async{
    var  databasePath = await getDatabasesPath();
    String path =await join(databasePath,"omar.db");
    await deleteDatabase(path);
    print("ddddddddddddddddddddddddddddddddddddd");
  }





 Future<List<Map<String,dynamic>>> read(String table) async{
    Database? mydb =await data;
    List<Map<String,dynamic>> response =await mydb!.query(table);
    return response;
  }
  Future<int> insert(String table, Map<String, Object?> values) async{
    Database? mydb =await data;
     if (mydb != null) {
     try {
        int  response =await mydb.insert(table,values );//قيمة الرو 
         return response;
       }   catch (e) {
          print(e);
          return 0;
        }}else {
    print("Error: Database is null.");
    return 0;
  }  
  }
  Future<int> update(String table, Map<String, Object?> values,String mywhere) async{
    Database? mydb =await data;
    int response =await mydb!.update(table,values, where: mywhere);
    return response;
  }
  Future<int> delete(String table,String mywhere) async{
    Database? mydb =await data;
    int response =await mydb!.delete(table, where: mywhere);
    return response;
  }



  
}