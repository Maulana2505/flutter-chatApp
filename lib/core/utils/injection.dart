import 'package:chatapp/core/utils/sharedprefrenced.dart';
import 'package:chatapp/features/auth/bloc/auth_bloc.dart';
import 'package:chatapp/features/auth/login/data/datasource/remoteDataSource/login_datasource.dart';
import 'package:chatapp/features/auth/login/data/repository/login_repository._impl.dart';
import 'package:chatapp/features/auth/login/domain/repository/login_repository.dart';
import 'package:chatapp/features/auth/login/domain/usecase/login_usecase.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:chatapp/features/auth/signup/data/datasource/remoteDataSource/signup_datasouce.dart';
import 'package:chatapp/features/auth/signup/data/repository/signup_repository_impl.dart';
import 'package:chatapp/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:chatapp/features/auth/signup/domain/usecase/signup_usecase.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:chatapp/features/chat/data/datasource/remote/chat_remote_datasource.dart';
import 'package:chatapp/features/chat/data/repository/chat_repository_impl.dart';
import 'package:chatapp/features/chat/domain/repository/chat_repository.dart';
import 'package:chatapp/features/chat/domain/usecase/chat_usecase.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/home/data/datasource/remote/home_datasource.dart';
import 'package:chatapp/features/home/data/repository/home_repository_impl.dart';
import 'package:chatapp/features/home/domain/repository/home_repository.dart';
import 'package:chatapp/features/home/domain/usecase/home_usecase.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/search/data/datasource/remote/search_datasource.dart';
import 'package:chatapp/features/search/data/repository/search_repository_impl.dart';
import 'package:chatapp/features/search/domain/repository/search_repository.dart';
import 'package:chatapp/features/search/domain/usecase/search_usecase.dart';
import 'package:chatapp/features/search/presentation/bloc/search_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setUp() {
  //external
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<SharedPreference>(SharedPreference());

  // Bloc
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignupBloc(sl()));
  sl.registerFactory(() => AuthenticationBloc());
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(
    () => GetchatBloc(sl(), sl()),
  );
  sl.registerFactory(() => SearchBloc(sl()));

  //Use Case
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
  sl.registerLazySingleton(
    () => HomeUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => GetChatUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => SendChatUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => SearchUsecase(sl()),
  );

  // Data Source
  sl.registerFactory<LoginDatasource>(() => LoginDatasourceImpl(sl()));
  sl.registerFactory<SignupDatasouce>(() => SignupDatasouceImpl(client: sl()));
  sl.registerFactory<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(sl()),
  );
  sl.registerFactory<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(sl()),
  );
  sl.registerFactory<SearchDatasource>(
    () => SearchDatasourceImpl(sl()),
  );

  //repository
  sl.registerFactory<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerFactory<SignupRepository>(
      () => SignupRepositoryImpl(signupDatasouce: sl()));
  sl.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(sl()),
  );
  sl.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(sl()),
  );

  sl.registerFactory<SearchRepository>(
    () => SearchRepositoryImpl(sl()),
  );
}
