import 'package:equatable/equatable.dart';
import 'package:new_app/data/model/photos/photo_response_model.dart';
import '../../../../core/error/error.dart';

enum PhotoStates { initial, loading, success, failure }

abstract class PhotoState extends Equatable {
  const PhotoState({required this.stateId});

  final PhotoStates stateId;

  @override
  List<Object> get props => [stateId];

  copyWith(PhotoState newState) {
    props.clear();
    props.addAll(newState.props);
  }
}

class Initial extends PhotoState {
  const Initial({super.stateId = PhotoStates.initial});
}

class Loading extends PhotoState {
  const Loading({super.stateId = PhotoStates.loading});

  @override
  List<Object> get props => [...super.props];
}

class Success extends PhotoState {
  const Success({required this.photoResponseModel, super.stateId = PhotoStates.success});

  final PhotoResponseModel photoResponseModel;

  @override
  List<Object> get props => [
        photoResponseModel,
        ...super.props
      ];
}

class Failure extends PhotoState {
  final AppError error;

  const Failure({required this.error, super.stateId = PhotoStates.failure});

  @override
  List<Object> get props => [error, ...super.props];
}
