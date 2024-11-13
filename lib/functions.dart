import 'downloder.dart';
import 'jsonclass.dart';
import 'localdb.dart';

Future<dynamic> getOnline_Version() async {
  try {
    dynamic text =
        await Utilities.Downloaddata("/ecommerce/assets/version.json");
    String s = ("${text["version"]}");
    int? vno = int.tryParse(s);
    if (vno != null) {
      return vno;
    } else {
      return 0;
    }
  } catch (ex) {
    print(ex);
    return -1;
  }
}

Future<dynamic> getOnlineData() async {
  try {
    dynamic text =
        await Utilities.Downloaddata("/ecommerce/assets/products.json");
    var data = text;

    if (data != null) {
      return data;
    } else {
      throw Exception("Downloading failed");
    }
  } catch (ex) {
    throw ex;
  }
}

Future<void> initDbData() async {
  var lst = await DatabaseHandler.jsons();
  print(lst);
  if (lst.length == 0) {
    var javabook = Json(1, 1, "");
    await DatabaseHandler.insertJson(javabook);
    print(await DatabaseHandler.jsons());
  }
}

Future<int> getLocal_Version() async {
  print("search");
  var list = await DatabaseHandler.jsons();
  List<Json> lst = list;
  return lst.first.version;
}

Future<void> Update_Data(int id, int version, String saree_data) async {
  var javabook = Json(id, version, saree_data);
  return await DatabaseHandler.updateJson(javabook);
}
