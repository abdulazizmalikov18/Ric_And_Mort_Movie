import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ric_and_mort_movie/core/use_case.dart';
import 'package:ric_and_mort_movie/data/model/dto/character/character_dto.dart';
import 'package:ric_and_mort_movie/data/model/dto/character/character_dto_extension.dart';
import 'package:ric_and_mort_movie/data/model/dto/episode/episode_dto_extension.dart';
import 'package:ric_and_mort_movie/data/remote/dio/data_state.dart';
import 'package:ric_and_mort_movie/data/remote/dio/dio_exception.dart';
import 'package:ric_and_mort_movie/data/repository/character_repository.dart';
import 'package:ric_and_mort_movie/data/repository/episode_repository.dart';

class GetCharacterDetail
    implements UseCase<DataState<CharacterDto>, GetCharacterDetailParams> {
  final CharacterRepository _characterRepository;
  final EpisodeRepository _episodeRepository;

  GetCharacterDetail(this._characterRepository, this._episodeRepository);

  @override
  Future<DataState<CharacterDto>> call(
      {required GetCharacterDetailParams params}) async {
    try {
      final httpResponse =
          await _characterRepository.getCharacter(params.characterId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        CharacterDto dto = httpResponse.data.toCharacterDto();
        if (dto.episodes != null && dto.episodes!.isNotEmpty) {
          for (var url in dto.episodes!) {
            int episodeId = url.getIdFromUrl();
            final episode = await _episodeRepository.getEpisode(episodeId);
            if (episode.response.statusCode == HttpStatus.ok) {
              dto.episodeDtoList.add(episode.data.toEpisodeDto());
            }
          }
        }
        return DataSuccess(dto);
      }
      return DataFailed(httpResponse.response.statusMessage);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (kDebugMode) {
        print(errorMessage);
      }
      return DataFailed(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataFailed(e.toString());
    }
  }
}

class GetCharacterDetailParams {
  final int characterId;

  GetCharacterDetailParams(this.characterId);
}
