import '../../../../core/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/model/photos/photo_response_model.dart';
import '../../repository/photos/photo_repo.dart';
import 'package:dartz/dartz.dart';

class GetOnlinePhoto implements UseCase<PhotoResponseModel?, NoParams> {
  final PhotoRepository photoRepository;

  GetOnlinePhoto({required this.photoRepository});

  @override
  Future<Either<AppError, PhotoResponseModel>> call(NoParams noParams) async {
    return await photoRepository.getPhoto();
  }
}