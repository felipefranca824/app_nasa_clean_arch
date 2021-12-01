import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';
import 'package:nasa_media/features/presenter/controller/home_store.dart';
import 'package:nasa_media/features/presenter/widgets/custom_shimmer.dart';
import 'package:nasa_media/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:nasa_media/features/presenter/widgets/image_network_with_loader.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;
  PicturePage({Key? key, this.dateSelected}) : super(key: key);

  PicturePage.fromArgs(dynamic args) {
    dateSelected = args['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed('/picture', arguments: {'dateSelected': dateSelected});
  }

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store,
      onLoading: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      onError: (context, error) => Center(
        child: Text(
          'An error ocurred, try again later.',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      onState: (context, SpaceMediaEntity spaceMedia) {
        return GestureDetector(
          onVerticalDragUpdate: (update) {
            if (update.delta.dy < 0) {
              showDescriptionBottomSheet(
                  context: context,
                  title: spaceMedia.title,
                  description: spaceMedia.description);
            }
          },
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: spaceMedia.mediaType == "video"
                    ? const Center(
                        child: Text('can\'t play the video'),
                      )
                    : spaceMedia.mediaType != null
                        ? ImageNetworkWithLoader(spaceMedia.mediaUrl)
                        : Container(),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: CustomShimmer(
                      child: Column(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_up,
                        size: 35,
                      ),
                      Text(
                        'Slide up to see the description',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
