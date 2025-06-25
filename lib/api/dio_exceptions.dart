import 'dart:io';
import 'package:dio/dio.dart';
import 'package:final_poject_sw_engineering/app/app_config.dart';
import 'package:final_poject_sw_engineering/app/app_constatns.dart';
import 'package:final_poject_sw_engineering/routes/app_routes.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

enum CustomDioErrorType { network, server, validation, unauthorized, unknown }

class DioExceptions implements Exception {
  final String message;
  final CustomDioErrorType errorType;

  DioExceptions._(this.message, this.errorType);

  factory DioExceptions.fromDioException(
    DioException dioError, {
    bool isPopupLoading = false,
  }) {
    String errorMessage;
    CustomDioErrorType errorType;

    if (isPopupLoading && Get.isDialogOpen == true) {
      Get.back();
      print('Closed dialog');
    }

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout with API server';
        errorType = CustomDioErrorType.network;
        break;

      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout in connection with API server';
        errorType = CustomDioErrorType.network;
        break;

      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout in connection with API server';
        errorType = CustomDioErrorType.network;
        break;

      case DioExceptionType.badCertificate:
        errorMessage = 'Invalid certificate from API server';
        errorType = CustomDioErrorType.network;
        break;

      case DioExceptionType.badResponse:
        final response = dioError.response;
        if (response != null) {
          errorMessage = _handleServerError(response.statusCode, response.data);
          errorType = _determineErrorType(response.statusCode);
          print(
            'Bad response: $errorMessage, Status: ${response.statusCode}',
          ); //
          // if (errorType == CustomDioErrorType.unauthorized) {
          //   // Navigate to login screen
          //   removeTokenAndRedirectLogin();
          // } // Debug
        } else {
          errorMessage = 'No response received from server';
          errorType = CustomDioErrorType.server;
        }
        break;

      case DioExceptionType.cancel:
        errorMessage = 'Request to API server was cancelled';
        errorType = CustomDioErrorType.unknown;
        break;

      case DioExceptionType.connectionError:
        errorMessage = dioError.error is SocketException
            ? 'No internet connection'
            : 'Connection error: ${dioError.error}';
        errorType = CustomDioErrorType.network;

        Get.offAndToNamed(AppRoutes.noConnectionScreen);
        break;

      default:
        errorMessage = 'Unexpected error: ${dioError.error}';
        errorType = CustomDioErrorType.unknown;
    }

    Utils.showSnackBar(
      message: errorMessage,
      type: SnackBarType.error,
    );

    return DioExceptions._(errorMessage, errorType);
  }

  static String _handleServerError(int? statusCode, dynamic error) {
    if (statusCode == null || error == null) {
      return 'Unknown server error';
    }

    final statusMessage =
        _extractStatusMessage(error) ?? 'Server error occurred';

    return switch (statusCode) {
      302 =>
        'Redirected to another URL. Check API endpoint or server configuration.',
      400 => statusMessage,
      // 401 => statusMessage,
      403 => statusMessage,
      404 => statusMessage,
      422 => _parseValidationErrors(error),
      429 => statusMessage,
      499 => statusMessage,
      500 => statusMessage,
      502 => 'Bad gateway',
      _ => _parseValidationErrors(error),
    };
  }

  static CustomDioErrorType _determineErrorType(int? statusCode) {
    return switch (statusCode) {
      401 || 403 => CustomDioErrorType.unauthorized,
      422 => CustomDioErrorType.validation,
      500 || 502 => CustomDioErrorType.server,
      _ => CustomDioErrorType.unknown,
    };
  }

  static String _parseValidationErrors(dynamic error) {
    final errors = _extractErrors(error);

    if (errors != null && errors is Map<String, dynamic> && errors.isNotEmpty) {
      return errors.values
          .expand((value) => value is List ? value : [value])
          .map((value) => value.toString())
          .join('\n');
    }

    final statusMessage = _extractStatusMessage(error);
    return statusMessage ?? 'Validation error occurred';
  }

  static String? _extractStatusMessage(dynamic error) {
    if (error is Map<String, dynamic>) {
      return error['message']?.toString();
    }
    return null;
  }

  static dynamic _extractErrors(dynamic error) {
    if (error is Map<String, dynamic>) {
      return error['errors'];
    }
    return null;
  }

  static removeTokenAndRedirectLogin() async {
    await AppConfig.remove(AppConstants.USER_TOKEN);
    await AppConfig.remove(AppConstants.USER_ROLE);
    await AppConfig.clear();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  String toString() => message;
}
