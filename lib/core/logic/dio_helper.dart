import 'package:dio/dio.dart';
 import 'package:thimar_course/core/logic/cache_helper.dart';

class DioHelper {
  final _dio = Dio(BaseOptions(
    baseUrl: "https://thimar.amr.aait-d.com/api/",
    headers: {
      "Accept": "application/json",


    },
  ));

  Future<CustomResponse> post(String endPoint,
      {Map<String, dynamic>? data}) async {
    print(data);
    try {
      final response = await _dio.post(endPoint,
          data: FormData.fromMap(data ?? {}),
          options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer ${CacheHelper.getToken()}",
              "Accept-Language": CacheHelper.getLanguage()
            },
          ));
      print(response.data);
      return CustomResponse(
        message: response.data["message"],
        isSuccess: true,
        response: response,
      );
    } on DioError catch (e) {
      print(e.response);
      print(e);
      return CustomResponse(
          message: e.response?.data["message"] ?? "Failed",
          isSuccess: false,
          response: e.response);
    }
  }

  Future<CustomResponse> get(String endPoint,
      {Map<String, dynamic>? params}) async {
    print(params);
    try {

      final response = await _dio.get(endPoint,
          queryParameters: params,
          options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer ${CacheHelper.getToken()}",
              "Accept-Language": CacheHelper.getLanguage()
            },
          ));
      print(response.data);
      return CustomResponse(
        message: response.data["message"],
        isSuccess: true,
        response: response,
      );
    } on DioError catch (e) {
      print(e);
      if (e.response!.statusCode == 404) {
        return CustomResponse(
            message: "Check Your EndPoint Page Not Founded",
            isSuccess: false,
            response: e.response);
      } else {
        return CustomResponse(
            message: e.response?.data["message"] ?? "Failed",
            isSuccess: false,
            response: e.response);
      }
    }
  }
}

class CustomResponse {
  final Response? response;
  final String message;
  final bool isSuccess;

  CustomResponse(
      {this.response, required this.message, required this.isSuccess});
}
