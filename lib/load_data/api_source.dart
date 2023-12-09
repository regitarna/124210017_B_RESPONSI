import 'package:responsi_regita/load_data/baseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String category) {
    return BaseNetwork.get("filter.php?c=" + category);
  }

  Future<Map<String, dynamic>> loadDetails(String id) {
    return BaseNetwork.get("lookup.php?i=" + id);
  }

}
