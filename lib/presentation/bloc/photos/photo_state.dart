import 'package:equatable/equatable.dart';
import 'package:new_app/data/model/photos/photo_response_model.dart';
import '../../../../core/error/error.dart';

enum PhotoStates {initial, loading, success, failure}

class PhotosState extends Equatable {
  const PhotosState({required this.props});

  @override
  final List<Object> props;

  PhotosState copyWith({List<Object>? newProps}) {
    return PhotosState(props: newProps ?? props);
  }
}

class Initial extends PhotosState {
  Initial({required this.stateId}) : super(props: [stateId]);
  final PhotoStates stateId;

  @override
  List<Object> get props => [stateId];
}

class Loading extends PhotosState {
  Loading({required this.stateId}) : super(props: [stateId]);
  final PhotoStates stateId;

  @override
  List<Object> get props => [stateId];
}

class Success extends PhotosState {
  Success({required this.photoResponseModel, required this.stateId})
      : super(props: [photoResponseModel, stateId]);

  final PhotoResponseModel photoResponseModel;
  final PhotoStates stateId;

  @override
  List<Object> get props => [photoResponseModel, stateId];
}

class Failure extends PhotosState {
  final AppError error;
  final PhotoStates stateId;

  Failure({required this.error, required this.stateId})
      : super(props: [error, stateId]);

  @override
  List<Object> get props => [error, stateId];
}
