import 'package:aha_ott_flutter_app/controller/all_movies_controller.dart';
import 'package:aha_ott_flutter_app/controller/all_series_controller.dart';
import 'package:aha_ott_flutter_app/controller/details_controller.dart';
import 'package:aha_ott_flutter_app/controller/home_controller.dart';
import 'package:aha_ott_flutter_app/controller/splash_controller.dart';
import 'package:aha_ott_flutter_app/data/repository/all_movies_repo.dart';
import 'package:aha_ott_flutter_app/data/repository/all_series_repo.dart';
import 'package:aha_ott_flutter_app/data/repository/details_repo.dart';
import 'package:aha_ott_flutter_app/data/repository/home_repo.dart';
import 'package:aha_ott_flutter_app/data/repository/search_repo.dart';
import 'package:aha_ott_flutter_app/utils/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/search_controller.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => DioClient(AppStrings.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///Repository
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DetailsRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AllMoviesRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AllSeriesRepo(dioClient: sl(), sharedPreferences: sl()));


  /// Controller
   Get.lazyPut(() => HomeController(homeRepo: sl()), fenix: true);
   Get.lazyPut(() => DetailsController(detailsRepo: sl()), fenix: true);
   Get.lazyPut(() => SearchControllerLoad(searchRepo: sl()), fenix: true);
   Get.lazyPut(() => AllMoviesController(allMoviesRepo: sl()), fenix: true);
   Get.lazyPut(() => AllSeriesController(allSeriesRepo: sl()), fenix: true);
   Get.lazyPut(() => SplashController(),fenix: true);


  /// External pocket lock
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}