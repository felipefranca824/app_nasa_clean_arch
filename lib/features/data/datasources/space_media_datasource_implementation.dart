import 'dart:convert';

import 'package:nasa_media/core/errors/exceptions.dart';
import 'package:nasa_media/core/http_client/http_client.dart';
import 'package:nasa_media/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_media/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_media/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_media/features/data/models/space_media_model.dart';

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;

  SpaceMediaDatasouceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.converter(date)));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
