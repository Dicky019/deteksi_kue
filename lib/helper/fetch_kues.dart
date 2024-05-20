import 'package:deteksi_kue/constant.dart';
import 'package:deteksi_kue/model/kue.dart';
import 'package:http/http.dart' as http;

Future<Kues> fetchData() async {
  final response = await http.get(Uri.parse(urlfetchKues));

  if (response.statusCode == 200) {
    return Kues.fromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
