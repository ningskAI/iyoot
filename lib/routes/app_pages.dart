import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:iyoot/modules/indexed/indexed_controller.dart';
import 'package:iyoot/modules/indexed/indexed_page.dart';
import 'package:iyoot/routes/route_path.dart';

class AppPages {
  AppPages._();

  static final routes = [
    // 首页
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),
      ],
    ),
  ];

}