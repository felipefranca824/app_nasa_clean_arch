import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_media/core/errors/exceptions.dart';
import 'package:nasa_media/core/errors/failures.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_media/features/data/models/space_media_model.dart';
import 'package:nasa_media/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'HAbjsdakmcalcã',
    title: 'jbljckçzc',
    mediaType: 'naclkançlmaç',
    mediaUrl: 'gcvakjckaç',
  );

  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Right(tSpaceMediaModel));

    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when calls the to datasource is unsucessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Left(ServerFailure()));
  });
}
