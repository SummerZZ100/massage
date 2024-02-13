import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'hot_key_data.dart';

/**
 *  历史记录工具类
 */


class HistoryKeyUtil {

  final MassageSearchHistoryKey = 'MassageSearchHistoryKey';

  /*
  * 刷新历史搜索关键词
  * */
  refreshSearchKey(String key,List<String> keys){
    if(key.isNotEmpty){
      int containsId = -1;
      for(int i = 0;i < keys.length;i++){
        String cKey = keys[i];
        if(key == cKey){
          containsId = i;
          break;
        }
      }
      if(containsId != -1){
        String temp = keys[containsId];
        keys.removeAt(containsId);
        keys.insert(0, temp);
      }
      else{
        keys.insert(0, key);
      }
      if(keys.length > 8){
        keys.removeLast();
      }
    }

  }

  /*
  * 保存历史记录
  * */
  saveHistory(HotKeyData data) async {

    String filePath = await _getFilePath(MassageSearchHistoryKey);
    File file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync(jsonEncode(data));

  }

  /*
  * 读取历史记录
  * */
  Future<List<String>> readHistory() async {

    String filePath = await _getFilePath(MassageSearchHistoryKey);
    File file = File(filePath);
    if (!file.existsSync()) {
      return [];
    }

    String infoContent = file.readAsStringSync();
    Map<String, dynamic>? infoMap = jsonDecode(infoContent);
    if(infoMap != null){
      HotKeyData infoDto = HotKeyData.fromJson(infoMap);
      return (infoDto.hotKeys ?? []);
    }
    return [];
  }

  Future<String> _getFilePath(String fileName) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentsPath = documentDirectory.path;
    return '$documentsPath/$fileName';
  }


}

