export 'test.dart';

Map<String, Map<String, dynamic>> separateData(String dataString) {
  List<String> values = dataString.trim().split('\n');
  Map<String, Map<String, dynamic>> dataDict = {};
  String value;
  for (value in values) {
    List<String> valueList = value.trim().split(',');
    String hostname = valueList[1];
    if (!dataDict.containsKey(hostname)) {
      dataDict[hostname] = {};
    }
    dataDict[hostname]['rostime'] = double.parse(valueList[0]);
    dataDict[hostname]['pos_x'] = double.parse(valueList[2]);
    dataDict[hostname]['pos_y'] = double.parse(valueList[3]);
    dataDict[hostname]['pos_desired_x'] = double.parse(valueList[4]);
    dataDict[hostname]['pos_desired_y'] = double.parse(valueList[5]);
    dataDict[hostname]['speed'] = double.parse(valueList[6]);
    dataDict[hostname]['speed_desired'] = double.parse(valueList[7]);
    dataDict[hostname]['soc'] = double.parse(valueList[8]);
    dataDict[hostname]['r'] = double.parse(valueList[9]);
    dataDict[hostname]['seg_id'] = valueList[10];
  }
  return dataDict;
}

Map<String, List<String>> isAvailable(String dataString) {
  Map<String, Map<String, dynamic>> dataDict = separateData(dataString);
  Map<String, List<String>> availability = {
    'available': [],
    'unavailable': []
  };
  dataDict.forEach((hostname, data) {
    if (data['speed'] > 0 || (data['pos_x'] != data['pos_desired_x'] || data['pos_y'] != data['pos_desired_y'])) {
      availability['unavailable'].add(hostname);
    } else {
      availability['available'].add(hostname);
    }
  });
  return availability;
}

void main() {
  var testcase1 =
      "0.0221610069275,manta_127,0.0,0.0,0.0,0.0,0,0,8.0,0.0,,0.0365769863129\n"
      "0.0337178707123,manta_128,0.0,0.0,0.0,0.0,0,0,8.0,0.0,,0.0545248985291\n"
      "0.0452747344971,manta_127,0.0,0.0,0.0,0.0,0,0,8.0,0.0,,0.0724728107452\n"
      "0.0568315982819,manta_128,0.0,0.0,0.0,0.0,0,0,8.0,0.0,,0.0904207230886\n"
      "0.0683884620667,manta_127,0.0,0.0,0.0,0.0,0,0,8.0,0.0,,0.108368635305\n"
      "0.1234567890123,manta_129,1.0,1.0,2.0,2.0,1.5,1.5,9.0,0.1,,0.1500000000000\n"
      "0.2345678901234,manta_130,3.0,3.0,3.5,3.5,2.0,2.5,7.5,0.2,,0.2500000000000\n";
  
  var dataDict = separateData(testcase1);
  print(dataDict['manta_127']['soc']);
  print(dataDict['manta_129']['pos_x']);
  print(dataDict['manta_130']['speed_desired']);

  var availability = isAvailable(testcase1);
  print("-------");
  print(availability['available']);
  print(availability['unavailable']);
  print("-------");
  print(dataDict);
}
