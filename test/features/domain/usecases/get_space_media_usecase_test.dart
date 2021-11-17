import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_media/core/errors/failures.dart';
import 'package:nasa_media/core/usecase/usecase.dart';
import 'package:nasa_media/features/domain/entities/space_media_entity.dart';
import 'package:nasa_media/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_media/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
      description: 'Descricao',
      mediaType: 'image ',
      title: 'Title',
      mediaUrl: 'http://');

  final tDate = DateTime(2021, 02, 02);
  test('should get space media entity for a given date from the repository',
      () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await usecase(tDate);
    expect(result, Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });
}
