import 'package:nasa_media/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_media/core/usecase/usecase.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';
import 'package:nasa_media/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaUsecase implements UseCase<SpaceMediaEntity, NoParams> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
