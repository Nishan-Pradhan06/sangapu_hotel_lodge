import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';

late final CacheOptions cacheOptions;

Future<void> initializeCache() async {
  final dir = await getApplicationDocumentsDirectory();

  cacheOptions = CacheOptions(
    store: HiveCacheStore("${dir.path}/api_cache"),

    policy: CachePolicy.refresh,

    hitCacheOnNetworkFailure: true,

    maxStale: const Duration(days: 30),

    priority: CachePriority.high,
  );
}
