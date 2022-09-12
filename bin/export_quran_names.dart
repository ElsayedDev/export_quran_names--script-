// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

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

void main(List<String> arguments) async {
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
