import 'package:bloc/bloc.dart';
import 'package:new_app/domain/usecase/photos/get_photo.dart';
import 'package:new_app/presentation/bloc/photos/photo_event.dart';
import 'package:new_app/presentation/bloc/photos/photo_state.dart';
import '../../../../core/usecase/usecase.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc({
    required this.getOnlinePhoto,
  }) : super(Initial(stateId: PhotoStates.initial)) {
    on<GetOnlinePhotosEvent>(_mapGetOnlinePhotosEventToState);
  }

  final GetOnlinePhoto getOnlinePhoto;

  Future _mapGetOnlinePhotosEventToState(
      GetOnlinePhotosEvent event, Emitter<PhotosState> emit) async {
    emit(Loading(stateId: PhotoStates.initial));
    return await getOnlinePhoto.call(NoParams()).then((result) {
      return result.fold((l) {
        emit(Failure(error: l, stateId: PhotoStates.failure));
      }, (r) {
        emit(Success(photoResponseModel: r, stateId: PhotoStates.success));
      });
    });
  }
}
