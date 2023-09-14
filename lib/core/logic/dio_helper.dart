import 'package:dio/dio.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';

class DioHelper {
  final _dio =
      Dio(BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/", headers: {
    "Accept": "application/json",
    "Authorization": "Bearer ${CacheHelper.getToken()}",
  }));

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
      print(e.toString());
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
      final response = await _dio.get(endPoint, queryParameters: params);
      print(response.data);
      return CustomResponse(
        message: response.data["message"],
        isSuccess: true,
        response: response,
      );
    } on DioError catch (e) {
      print(e.toString());
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

// import 'package:dio/dio.dart';
//
// class DioHelper{
//   static Dio? dio;
//
//   static init(){
//     dio = Dio(
//         BaseOptions(
//           baseUrl:'https://thimar.amr.aait-d.com/public/api/' ,
//           receiveDataWhenStatusError: true,
//
//         )
//     );
//   }
//
//
//   static Future<Response> getData({
//     required String url,
//     required Map<String, dynamic> query,
//     String lang ='ar',
//     String? token,
//   }
//
//       ) async
//   {
//     dio!.options=BaseOptions(
//         headers: {
//           'lang':lang,
//           'token':token
//         }
//     );
//     return await dio!.get(url,queryParameters:query);
//   }
//
//
//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic> data,
//     String lang ='ar',
//     String? token,
//   }) async
//   {
//     dio!.options.headers={
//       'lang':lang,
//       'token':token
//     };
//     return await dio!.post(
//       url,
//       queryParameters:query,
//       data: data,
//     );
//   }
// }

