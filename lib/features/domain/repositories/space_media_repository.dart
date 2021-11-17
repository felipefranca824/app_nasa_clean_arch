import 'package:dartz/dartz.dart';
import 'package:nasa_media/core/errors/failures.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
