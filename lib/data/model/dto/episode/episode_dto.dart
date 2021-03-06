import 'package:ric_and_mort_movie/data/model/dto/character/character_dto.dart';

class EpisodeDto {
  final int? id;
  final String? name;
  final String? url;
  final String? airDate;
  final String? created;
  final String? episode;
  final List<String>? characters;
  List<CharacterDto> characterDtoList = [];

  EpisodeDto(this.id, this.name, this.url, this.airDate, this.created,
      this.episode, this.characters);
}
