import 'package:equatable/equatable.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();
}

class GetOnlinePhotosEvent extends PhotosEvent {

  const GetOnlinePhotosEvent();

  List<Object?> get props => [];
}
