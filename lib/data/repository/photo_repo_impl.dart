import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../core/error/error.dart';
import '../../domain/repository/photos/photo_repo.dart';
import '../datasource/photos/photos_remote_datasource.dart';
import '../model/photos/photo_response_model.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource photoRemoteDataSource;
  final NetworkInfo networkInfo;

  PhotoRepositoryImpl({
    required this.photoRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<AppError, PhotoResponseModel>> getPhoto() async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response =
        await photoRemoteDataSource.getPhoto();
        return response == null
            ? const Left(ServerFailure(AppStrings.errorDataFromServerIsNull))
            : Right(response);
      } on AppException catch (exp) {
        return Left(ServerFailure(exp.errorMessage));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
