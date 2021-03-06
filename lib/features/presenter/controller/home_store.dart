import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_media/core/errors/failures.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';
import 'package:nasa_media/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(SpaceMediaEntity(
            description: "", mediaType: "", title: "", mediaUrl: ""));

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);

    final result = await usecase(date);

    result.fold((error) => setError(error), (success) => update(success));

    setLoading(false);
  }
}
