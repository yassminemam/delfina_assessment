import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/flavour_config.dart';
import 'core/network/network_info.dart';
import 'core/util/dio_logging_interceptor.dart';
import 'data/datasource/photos/photos_remote_datasource.dart';
import 'data/repository/photo_repo_impl.dart';
import 'domain/repository/photos/photo_repo.dart';
import 'domain/usecase/photos/get_photo.dart';
import 'presentation/bloc/photos/photo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Core
   */
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    Map<String, dynamic> header = {};
    header['Content-Type'] = "application/json";
    header['Accept'] = "application/json";
    dio.options.headers = header;
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  });

  sl.registerLazySingletonAsync<SharedPreferences>(() {
    final sharedPref = SharedPreferences.getInstance();
    return sharedPref;
  });
  await sl.isReady<SharedPreferences>();
  /**
   * ! Features
   */
  // Data Source
  sl.registerLazySingleton<PhotoRemoteDataSource>(
      () => PhotoRemoteDataSourceImpl(dio: sl()));

  // Repository
  sl.registerLazySingleton<PhotoRepository>(() =>
      PhotoRepositoryImpl(photoRemoteDataSource: sl(), networkInfo: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetOnlinePhoto(photoRepository: sl()));

  // Bloc
  sl.registerFactory(
    () => PhotosBloc(
      getOnlinePhoto: sl(),
    ),
  );
}
