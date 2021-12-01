import 'package:nasa_media/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_media/core/usecase/usecase.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';
import 'package:nasa_media/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements UseCase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    return date != null
        ? await repository.getSpaceMediaFromDate(date)
        : Left(NullParamFailure());
  }
}
