import 'package:flutter/foundation.dart';
import 'package:ric_and_mort_movie/app/di/injector.dart';
import 'package:ric_and_mort_movie/core/view_state.dart';
import 'package:ric_and_mort_movie/data/model/dto/episode/episode_dto.dart';
import 'package:ric_and_mort_movie/data/remote/dio/data_state.dart';
import 'package:ric_and_mort_movie/domain/episode/get_episode_detail.dart';
import 'package:stacked/stacked.dart';

class EpisodeDetailViewModel extends BaseViewModel {
  final GetEpisodeDetail _getEpisodeDetail = injector<GetEpisodeDetail>();
  ViewState<EpisodeDto> viewState = ViewState(state: ResponseState.EMPTY);

  EpisodeDto? dto;

  void _setViewState(ViewState<EpisodeDto> viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> loadDetail(int id) async {
    _setViewState(ViewState.loading());
    final detail =
        await _getEpisodeDetail.call(params: GetEpisodeDetailParams(id));
    if (detail is DataSuccess) {
      dto = detail.data;
      _setViewState(ViewState.complete(dto!));
    }
    if (detail is DataFailed) {
      if (kDebugMode) {
        print(detail.error);
      }
      _setViewState(ViewState.error(detail.error.toString()));
    }
  }
}
