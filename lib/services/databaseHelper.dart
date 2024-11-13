import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
class DatabaseHelper{
    static final DatabaseHelper _instance = DatabaseHelper.internal();
    static Database? _database;
    static String? url = dotenv.env['API_URL'];
    factory DatabaseHelper() => _instance;
    DatabaseHelper.internal();
    Future<Database?> get db async {
        if (_database != null) {
            return _database;
        }
        _database = await initDb();
        return _database;
    }
    Future<Database> initDb() async {
        String path = join(await getDatabasesPath(), 'database.db');
        var db = await openDatabase(path, version: 1, onCreate: _onCreate);
        return db;
    }
    void _onCreate(Database db, int version) async {
        await db.execute('''
      CREATE TABLE carousels(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT
      )
    ''');
    }
    Future carouselGet() async {
        Database? dbClient = await db;
        if (dbClient == null) {
            print("Error: No se pudo obtener la instancia de la base de datos.");
            return;
        }

        var res = await http.get(Uri.parse('$url/carouselsPage'));
        var body = json.decode(res.body);
        List<dynamic> carousels = body;

        await dbClient.delete('carousels');
        for (var carousel in carousels) {
            String? localPath = await downloadImage(carousel['image']);
            print(localPath);
            await dbClient.insert('carousels', {
                'id': carousel['id'],
                'title': carousel['image'],
                'image': localPath
            });
        }

        return await dbClient.query('carousels');
    }
    Future<String?> downloadImage(String urlImage) async {
        try {
            // print('$url/../images/$urlImage');
            // print(urlImage);
            var res = await http.get(Uri.parse('$url/../images/$urlImage'));
            if (res.statusCode == 200) {
                final directory = await getApplicationDocumentsDirectory();
                String imagePath = '${directory.path}/carousels';
                await Directory(imagePath).create(recursive: true);
                File file = File('$imagePath/${urlImage.split('/').last}');
                await file.writeAsBytes(res.bodyBytes);
                return file.path;
            }else{
                return null;
            }
        } catch (e) {
            return null;
        }
    }


}