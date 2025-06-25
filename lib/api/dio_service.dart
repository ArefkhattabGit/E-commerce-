
import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/app/app_config.dart';
import 'package:dio/dio.dart' as dioFormData;

import '../app/app_constatns.dart';

class DioService {
  DioService._();

  static final Dio dioService = _createDio();

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: Duration(seconds: AppConstants.connectionTimeout),
          receiveTimeout: Duration(seconds: AppConstants.connectionTimeout),
          responseType: ResponseType.json,
          headers: {
            "Accept":"application/json"
          }),
    );

    dio.interceptors.addAll([
      _createLoggerInterceptor(),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    ]);

    return dio;
  }

  static InterceptorsWrapper _createLoggerInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] = getToken();
        final headers = options.headers.entries
            .map((e) => '| ${e.key}: ${e.value}')
            .join('\n');
        _log(
          '''
┌------------------------------------------------------------------------------ 
| [DIO] Request: ${options.method} ${options.uri}
| Data: ${options.data?.toString() ?? 'No data'}
| Headers:\n$headers
├------------------------------------------------------------------------------''',
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        _log(
          '''
| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}
└------------------------------------------------------------------------------''',
        );
        handler.next(response);
      },
      onError: (error, handler) {
        _log(
          '''
| [DIO] Error: ${error.error}: ${error.response?.toString() ?? 'No response'}
└------------------------------------------------------------------------------''',
        );
        handler.next(error);
      },
    );
  }

  static Future<FormData> toFormData({
    required String jsonKey,
    required String filePath,
    required String fileName,
    Map<String, dynamic>? jsonObject,
  }) async {
    final data = jsonObject ?? {};
    try {
      data[jsonKey] = await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      );
      return FormData.fromMap(data);
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: filePath),
        error: 'Failed to create FormData: $e',
      );
    }
  }

  static String getToken() {
    String? auth = AppConfig.getString(AppConstants.USER_TOKEN);
    return auth != null ? "Bearer $auth" : "";
  }

  static void _log(String message) {
    message.split('\n').forEach(print);
  }
}
// addFormDataToJson(
//     {jsonKey, filePath, fileName, Map<String, dynamic>? jsonObject}) async {
//   jsonObject![jsonKey] = await dioFormData.MultipartFile.fromFile(
//     filePath,
//     filename: fileName,
//   );
//   return dioFormData.FormData.fromMap(jsonObject);
// }
addFormDataToJson(
    {jsonKey, filePath, fileName, Map<String, dynamic>? jsonObject}) async {
  jsonObject![jsonKey] = await dioFormData.MultipartFile.fromFile(
    filePath,
    filename: fileName,
  );
  return dioFormData.FormData.fromMap(jsonObject);
}
