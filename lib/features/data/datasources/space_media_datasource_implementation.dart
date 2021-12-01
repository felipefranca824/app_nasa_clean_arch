import 'dart:convert';

import 'package:nasa_media/core/errors/exceptions.dart';
import 'package:nasa_media/core/utils/converters/date_input_formater.dart';
import 'package:nasa_media/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_media/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_media/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_media/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final http.Client client;
  final DateInputConverter converter;

  SpaceMediaDatasouceImplementation({
    required this.client,
    required this.converter,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client
        .get(NasaEndpoints.getSpaceMedia('DEMO_KEY', dateConverted));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
