import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  //api를 통해 json 파일을 읽는다
  var apiKey="sample";
  var start = 1;
  var end = 5;
  final response = await http.get(Uri.parse(
      'https://openapi.foodsafetykorea.go.kr/api/$apiKey/COOKRCP01/json/$start/$end')); //sample에 apiKey 넣어줘야한다. 데이터는 1318개정도있고, 한번에 1000개만 불러올수있다. call제한회수 1000회/1일

  if (response.statusCode == 200) {
    //openAPI 서버로부터 정상적으로 데이터를 받으면
    print("the server returned a 200 response");

    
    //COOKRCP01.json 파일을 읽어온다
    String jsonString = response.body;
    
    //COOKRCP01.json 이름의 로컬 File로 저장한다.
    saveAsFile(jsonString);
    
    
  } else {
    //서버로부터 데이터를 받지못하면
    throw Exception('Failed to load data');
  }
}


  Future<File> saveAsFile(String jsonString) async {
    //파일경로
    final file = File('source/COOKRCP01.json');

    // 파일 쓰기
    return file.writeAsString(jsonString);
  }