import 'package:flutter/material.dart';
import 'package:new_app/core/constants/strings/app_strings.dart';
import 'package:new_app/data/model/photos/photo_response_model.dart';
import 'package:new_app/presentation/bloc/photos/photo_bloc.dart';
import 'package:new_app/presentation/bloc/photos/photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/strings/app_assets.dart';
import '../../../injection_container.dart';
import '../../core/constants/colors/app_colors.dart';
import '../bloc/photos/photo_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    PhotosBloc photosBloc = BlocProvider.of<PhotosBloc>(context);
    photosBloc.add(const GetOnlinePhotosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PhotosBloc, PhotosState>(
          bloc: sl(),
          buildWhen: (oldS, newS) {
            return (oldS != newS);
          },
          builder: (BuildContext context, state) {
            if (state is Success) {
              PhotoResponseModel photo = (state.props[0] as PhotoResponseModel);
              return Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (photo.urls != null && photo.urls!
                                    .regular != null)
                                    ? NetworkImage(photo.urls!.regular ?? "")
                                    : const AssetImage(AppAssets
                                    .errorImg) as ImageProvider,
                              )))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey)),
                          child: const Text(AppStrings.pause)),
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey)),
                          child: const Text(AppStrings.play)),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey)),
                      child: const Text(AppStrings.rewind)),
                  const Spacer(),
                ],
              );
            } else if (state is Failure) {
              return const Center(
                child: Text(AppStrings.errorLoadingPhoto),
              );
            }
            //in this case the state is Initial or Loading
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.appMainColor,
              ),
            );
          },
          listener: (BuildContext context, PhotosState state) {},
        ));
  }
}
