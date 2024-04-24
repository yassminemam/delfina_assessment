import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/base_url_config.dart';
import 'config/flavour_config.dart';
import 'core/constants/colors/app_colors.dart';
import 'presentation/bloc/photos/photos_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
      flavor: Flavor.DEVELOPMENT,
      values: FlavorValues(baseUrl: BaseUrlConfig.baseUrlDevelopment));
  await di.init();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PhotosBloc>(
            create: (context) => sl<PhotosBloc>(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme:
                  const ColorScheme.light(primary: AppColors.appMainColor),
            ),
          ),
        ));
  }
}
