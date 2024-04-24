import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:new_app/core/constants/strings/app_assets.dart';
import 'package:new_app/core/constants/strings/app_strings.dart';
import '../../../../config/end_poits.dart';
import '../../../../core/error/app_server_error.dart';
import '../../../../core/error/exception.dart';
import '../../model/photos/photo_response_model.dart';

abstract class PhotoRemoteDataSource {
  Future<PhotoResponseModel?> getPhoto();
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final Dio dio;

  PhotoRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PhotoResponseModel?> getPhoto() async {
    try {
      final completer = Completer<String>();
      await loadKeysFromAsset().then((keysMap) {
        completer.complete(keysMap["access_key"]);
      });
      Map<String, dynamic>? queryParams = {};
      await completer.future.then((accessKey) {
        queryParams = {
          "query": AppStrings.queryValue,
          "client_id": accessKey
        };
      });
      if (completer.isCompleted) {
        var response =
        await dio.get(EndPoints.getPhotos, queryParameters: queryParams);
        if (response.statusCode == 200) {
          PhotoResponseModel photoResponseModel =
          PhotoResponseModel.fromJson(response.data);
          return photoResponseModel;
        }
      }
    } on DioException catch (ex) {
      AppServerError? error =
          AppServerError.fromJson(ex.response?.data ?? ex.message);
      throw AppException(error?.toString() ?? AppStrings.errorUnknownServer);
    }
    return null;
  }

  Future<Map<String, dynamic>> loadKeysFromAsset() async {
    String content = await rootBundle.loadString(AppAssets.keysFilePath);
    Map<String, dynamic> keysAsMap = json.decode(content);
    return keysAsMap;
  }
}
