import 'package:retrofit/retrofit.dart';
import 'package:ric_and_mort_movie/data/model/remote/episode/EpisodeInfo.dart';
import 'package:ric_and_mort_movie/data/model/remote/episode/EpisodeResponse.dart';
import 'package:ric_and_mort_movie/data/remote/service/episode/episode_service.dart';

class EpisodeRepository {
  final EpisodeService _episodeService;

  EpisodeRepository(this._episodeService);

  Future<HttpResponse<EpisodeResponse>> getEpisodes(
    int page,
    Map<String, String>? options,
  ) => _episodeService.getEpisodes(page, options);

  Future<HttpResponse<EpisodeInfo>> getEpisode(int id) =>
      _episodeService.getEpisode(id);
}
