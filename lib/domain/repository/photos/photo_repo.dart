import 'package:dartz/dartz.dart';
import '../../../../core/error/error.dart';
import '../../../data/model/photos/photo_response_model.dart';

abstract class PhotoRepository {
  Future<Either<AppError, PhotoResponseModel>> getPhoto();
}