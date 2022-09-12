// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:io';

// import 'db_quran.dart';
// import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);
  return map;
}

writeMapFile({
  required String outputFilePath,
  required Object map,
}) async {
  final File file = File(outputFilePath);

  file.writeAsStringSync(
    json.encode(
      map,
    ),
  );
}

writeInfo() async {
  const String read_name_in_Arabic_path = "assets/hafs_smart_v8.json";
  const String read_page_number_path = "assets/surah_names.json";
  const String outputFilePath =
      '/home/elsayeddev/work/dart_projects/surahs_names.json';
  int coutDone = 0;
  List<Map<String, dynamic>> map = [];
  final read_name_in_Arabic_file = await readJsonFile(read_name_in_Arabic_path);
  final read_page_number_file = await readJsonFile(read_page_number_path);

  for (var element in read_name_in_Arabic_file) {
    final int sura_no = element['sura_no'];
    if (sura_no > coutDone) {
      map.add(
        {
          "surah_no": sura_no,
          "page_number": read_page_number_file[coutDone]["page_number"],
          "surah_name_ar": element["sura_name_ar"],
          "surah_name_en": element["sura_name_en"],
        },
      );
      coutDone++;
    }
  }
  await writeMapFile(
    outputFilePath: outputFilePath,
    map: map,
  );
}

_encodeQuranSurahsInfo() async {
  // open db and then encode to json
  print("quran_floating_action:: start function");

  final EncodeQuranSurahsInfoDatabase encodeQuranSurahsInfoDatabase =
      EncodeQuranSurahsInfoDatabase();

  List<Map<String, dynamic>> all_dimensions = [];
  for (var i = 1; i <= 114; i++) {
    final result = await encodeQuranSurahsInfoDatabase.getMapDB(i);

    all_dimensions.add(result);
  }
  await writeInfoV2(all_dimensions);

  print("quran_floating_action:: done!!");
}

writeInfoV2(List<Map<String, dynamic>> dimensions) async {
  const String read_surah_info_path = "assets/surahs_info.json";
  const String outputFilePath =
      '/home/elsayeddev/work/dart_projects/surahs_info.json';
  List<Map<String, dynamic>> map = [];

  final read_page_number_file = await readJsonFile(read_surah_info_path);

  int coutDone = 0;
  for (var element in read_page_number_file) {
    map.add(
      {
        "id": coutDone + 1,
        "surah_no": element["surah_no"],
        "x": dimensions[coutDone]["x"],
        "y": dimensions[coutDone]["y"],
        "width": dimensions[coutDone]["width"],
        "height": dimensions[coutDone]["height"],
        "page_number": read_page_number_file[coutDone]["page_number"],
        "surah_name_ar": element["surah_name_ar"],
        "surah_name_en": element["surah_name_en"],
      },
    );
    coutDone++;
  }
  await writeMapFile(
    outputFilePath: outputFilePath,
    map: map,
  );
}

void main(List<String> arguments) async {
  await _encodeQuranSurahsInfo();
}

class EncodeQuranSurahsInfoDatabase {
  Future<Map<String, dynamic>> getMapDB(int surah_number) async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(
        "/home/elsayeddev/work/dart_projects/export_quran_names/assets/hafsMadinaThirdCopy_quran.db");

    final List<dynamic> result =
        await db.query("soraHeader", where: "surah= $surah_number");

    return result[0];
  }
}
