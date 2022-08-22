import 'package:gits_strapi/gits_strapi.dart';

extension GitsStrapiUriExtension on Uri {
  Uri withParam(StrapiRequest param) {
    final parameters = <String, dynamic>{};
    if (param.page != null) {
      parameters['pagination[page]'] = param.page.toString();
    }

    if (param.pageSize != null) {
      parameters['pagination[pageSize]'] = param.pageSize.toString();
    }

    if (param.withCount != null) {
      parameters['pagination[withCount]'] = param.withCount.toString();
    }

    if (param.populate != null) {
      for (var i = 0; i < param.populate!.length; i++) {
        parameters['populate[${i.toString()}]'] = param.populate![i];
      }
    }

    if (param.sort != null) {
      for (var i = 0; i < param.sort!.length; i++) {
        parameters['sort[${i.toString()}]'] = param.sort![i];
      }
    }

    if (param.fields != null) {
      for (var i = 0; i < param.sort!.length; i++) {
        parameters['fields[${i.toString()}]'] = param.sort![i];
      }
    }

    return replace(queryParameters: parameters);
  }
}
