import 'package:iyoot/http/loading_state.dart';
import 'package:iyoot/pages/common/common_list_page.dart';

class TVController
    extends CommonListController{
  @override
  Future<LoadingState<dynamic>> customGetData() {
    return test();
  }

  static Future<LoadingState<dynamic>> test() async {
    return Success("");
  }

}