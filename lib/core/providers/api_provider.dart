import 'package:news_app/core/api_client.dart';
import 'package:news_app/core/injector.dart';

class ApiProvider {
  final RestApiClient _client = Injector().getClient();
}
