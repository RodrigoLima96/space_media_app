import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/converters/converters.dart';
import '../models/models.dart';
import 'datasources.dart';
import 'endpoints/endpoints.dart';

class SpaceMediaDatasourceImpl implements ISpaceMediaDatasource {
  final DateToStringConverter converter;
  final http.Client client;

  const SpaceMediaDatasourceImpl(
      {required this.client, required this.converter});

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(
      {required DateTime date}) async {
    final stringDate = converter.convert(date: date);
    final response =
        await client.get(NasaEndpoints.getSpaceMedia('DEMO_KEY', stringDate));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
