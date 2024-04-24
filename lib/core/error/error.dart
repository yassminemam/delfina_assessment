import 'package:equatable/equatable.dart';
import '../constants/strings/app_strings.dart';

abstract class AppError extends Equatable {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  const AppError(this._errorMessage);
}

const String messageConnectionFailure = AppStrings.errorNoInternetConnection;
const String messageCacheFailure = AppStrings.errorCanNotAccessCache;

class ServerFailure extends AppError {
  final String error;

  const ServerFailure(this.error) : super(error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $error}';
  }
}

class CacheFailure extends AppError {

  const CacheFailure() : super(messageCacheFailure);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'CacheFailure{errorMessage: $messageCacheFailure}';
  }
}

class ConnectionFailure extends AppError {
  const ConnectionFailure() : super(messageConnectionFailure);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $messageConnectionFailure}';
  }
}
