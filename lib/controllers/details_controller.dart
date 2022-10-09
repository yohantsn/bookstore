import 'package:bookstore/tools/tools.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IDetailsController {
  Future<void> openSelfLink(String url);
}

class DetailsController implements IDetailsController {
  @override
  Future<void> openSelfLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw (StringUtil.erroToOpenBuyLink);
    }
  }
}
