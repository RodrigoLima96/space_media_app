import 'dart:convert';

import 'package:space_media_app/core/errors/errors.dart';

import '../../../../core/http/http.dart';
import '../../../../core/utils/api_keys/api_keys.dart';
import '../../../../core/utils/converters/converters.dart';
import '../models/models.dart';
import 'datasources.dart';
import 'endpoints/endpoints.dart';

class NasaDatasourceImpl implements ISpaceMediaDatasource {
  final HttpClient client;

  const NasaDatasourceImpl({required this.client});

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(
      {required DateTime date}) async {
    final response = await client.get(
      url: NasaEndpoints.apod(
        apiKey: NasaApiKeys.apiKey,
        date: DateToStringConverter.convert(date: date),
      ),
    );

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
