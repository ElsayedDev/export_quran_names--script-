// ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'db_interface.dart';

class SurahInfoDatabase extends IDatabaseHelper {
  SurahInfoDatabase._() : super("hafsMadinaThirdCopy_quran.db", "assets");

  static final SurahInfoDatabase instance = SurahInfoDatabase._();

  Future<List<Map<String, dynamic>>> getSurahInfo(int surah_number) async {
    // open data base
    Database db = await super.openData();

    // selection condition
    final String condition = 'surah = $surah_number';

    final fund = await db.query(
      'soraHeader',
      where: condition,
      distinct: true,
    );

    print("TEST SurahInfoDatabase:: $fund");

    db.close();

    return fund;
  }
}

// class SurahInfoModel {
//   final int surah_number;
//   final int page_number;
//   final String surah_name_ar;

//   const SurahInfoModel({
//     required this.surah_number,
//     required this.page_number,
//     required this.surah_name_ar,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'surah_number': surah_number,
//       'page_number': page_number,
//       'surah_name_ar': surah_name_ar,
//     };
//   }

//   factory SurahInfoModel.fromMap(Map<String, dynamic> map) {
//     return SurahInfoModel(
//       surah_number: map['surah_number']?.toInt() ?? 0,
//       page_number: map['page_number']?.toInt() ?? 0,
//       surah_name_ar: map['surah_name_ar'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SurahInfoModel.fromJson(String source) =>
//       SurahInfoModel.fromMap(json.decode(source));
// }
