import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_media/core/errors/exceptions.dart';
import 'package:nasa_media/core/http_client/http_client.dart';
import 'package:nasa_media/core/utils/converters/date_input_formater.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_media/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

import '../../mocks/space_media_mock.dart';

class HttpClientMocking extends Mock implements http.Client {}

class MockDateInputConverter extends Mock implements DateInputConverter {}

void main() {
  late ISpaceMediaDatasource datasource;
  late http.Client client;
  late DateInputConverter converter;

  setUp(() {
    client = HttpClientMocking();
    converter = MockDateInputConverter();
    datasource =
        SpaceMediaDatasouceImplementation(client: client, converter: converter);
    registerFallbackValue(DateTime(2000));
    registerFallbackValue(Uri());
  });

  DateTime tDateTime = DateTime(2021, 02, 02);
  const tDateTimeString = '2021-02-02';

  const urlExpected =
      "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02";

  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('should call the get method with correct url', () async {
    successMock();

    await datasource.getSpaceMediaFromDate(tDateTime);

    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    successMock();
    final tSpaceModelExpected = SpaceMediaModel(
        description:
            "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
        mediaType: "image",
        title: "A Colorful Quadrantid Meteor",
        mediaUrl:
            "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg");

    final result = await datasource.getSpaceMediaFromDate(tDateTime);

    expect(result, tSpaceModelExpected);
    verify(() => converter.format(tDateTime)).called(1);
  });

  test("should throws a ServerException when the call is unccessful", () async {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));

    final result = datasource.getSpaceMediaFromDate(tDateTime);

    expect(() => result, throwsA(ServerException()));
  });
}
