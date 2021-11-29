import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_media/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_media/features/presenter/controller/home_store.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore homeStore;
  late GetSpaceMediaFromDateUsecase usecase;

  setUp(() {
    usecase = MockGetSpaceMediaFromDateUsecase();
    homeStore = HomeStore(usecase);
    registerFallbackValue(DateTime(0, 0, 0));
  });

  test('should return a SpaceMedia from the usecase', () async {
    when(() => usecase(any())).thenAnswer((_) async => Right(tSpaceMedia));

    await homeStore.getSpaceMediaFromDate(tDate);

    homeStore.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => usecase(tDate)).called(1);
    });
  });
}
