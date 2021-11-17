import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_media/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_media/features/domain/usecases/get_space_media_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main(List<String> args) {
  GetSpaceMediaUsecase usecase;
  ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaUsecase(repository);
  });

  test('should get space media entity for a given date from the repository',
      () {});
}
