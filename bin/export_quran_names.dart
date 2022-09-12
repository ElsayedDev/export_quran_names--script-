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
  const String jsonPath = "assets/hafs_smart_v8.json";
  const String outputFilePath =
      '/home/elsayeddev/work/dart_projects/surahs_names.json';
  int coutDone = 0;
  List<Map<String, dynamic>> map = [];
  final readFile = await readJsonFile(jsonPath);

  for (var element in readFile) {
    final int sura_no = element['sura_no'];
    if (sura_no > coutDone) {
      map.add(
        {
          "sura_no": sura_no,
          "sura_name_ar": element["sura_name_ar"],
          "sura_name_en": element["sura_name_en"],
        },
      );
      coutDone++;
    }
  }
  print(map);
  await writeMapFile(
    outputFilePath: outputFilePath,
    map: map,
  );
}
