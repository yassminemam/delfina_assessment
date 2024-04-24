import 'package:flutter/material.dart';
import 'package:new_app/core/constants/strings/app_strings.dart';
import 'package:new_app/data/model/photos/photo_response_model.dart';
import 'package:new_app/presentation/bloc/photos/photos_bloc.dart';
import 'package:new_app/presentation/bloc/photos/photos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/strings/app_assets.dart';
import '../../../injection_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: BlocBuilder<PhotosBloc, PhotoState>(
          bloc: sl(),
          buildWhen: (previous, current) =>
              previous != current && current is Success,
          builder: (cxt, state){
            PhotoResponseModel photo = (state.props[0] as PhotoResponseModel);
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (photo.urls != null &&
                          photo.urls!.regular != null)
                          ? NetworkImage(photo.urls!.regular ?? "")
                          : const AssetImage(AppAssets.errorImg) as ImageProvider,
                    )));
          },
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () {}, child: const Text(AppStrings.pause)),
            TextButton(onPressed: () {}, child: const Text(AppStrings.play)),
          ],
        ),
        TextButton(onPressed: () {}, child: const Text(AppStrings.rewind)),
      ],
    ));
  }
}
