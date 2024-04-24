import 'package:bloc/bloc.dart';
import 'package:new_app/domain/usecase/photos/get_photo.dart';
import 'package:new_app/presentation/bloc/photos/photos_event.dart';
import 'package:new_app/presentation/bloc/photos/photos_state.dart';

import '../../../../core/usecase/usecase.dart';

abstract class PhotosBaseBloc extends Bloc<PhotosEvent, PhotoState> {
  PhotosBaseBloc(PhotoState state) : super(const Initial());
}

class PhotosBloc extends PhotosBaseBloc {
  PhotosBloc({
    required this.getOnlinePhoto,
  }) : super(const Initial()) {
    on<GetOnlinePhotosEvent>(_mapGetOnlinePhotosEventToState);
  }

  final GetOnlinePhoto getOnlinePhoto;

  void _mapGetOnlinePhotosEventToState(
      GetOnlinePhotosEvent event, Emitter<PhotoState> emit) async {
    emit(
      state.copyWith(const Loading()),
    );
    await getOnlinePhoto.call(NoParams()).then((result) {
      result.fold((l) {
        emit(
          state.copyWith(
            Failure(error: l)
          ),
        );
      }, (r) {
        emit(
          state.copyWith(
            Success(photoResponseModel: r)
          ),
        );
      });
    });
  }
}
