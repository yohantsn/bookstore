import 'package:bookstore/controllers/controllers.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockUrlLauncher extends Mock implements UrlLauncherPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final IDetailsController detailsController;
  const url = "https://www.google.com";

  setUpAll(() {
    detailsController = DetailsController();
  });

  group("Details controllers", () {
    test("read favorites", () async {
      expectLater(detailsController.openSelfLink(url), throwsException);
    });
  });
}
