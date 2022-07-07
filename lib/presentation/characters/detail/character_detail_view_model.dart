import 'package:flutter/foundation.dart';
import 'package:ric_and_mort_movie/app/di/injector.dart';
import 'package:ric_and_mort_movie/core/view_state.dart';
import 'package:ric_and_mort_movie/data/model/dto/character/character_dto.dart';
import 'package:ric_and_mort_movie/data/remote/dio/data_state.dart';
import 'package:ric_and_mort_movie/domain/character/get_character_detail.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final GetCharacterDetail _getCharacterDetail = injector<GetCharacterDetail>();
  ViewState<CharacterDto> viewState = ViewState(state: ResponseState.EMPTY);

  CharacterDto? dto;

  void _setViewState(ViewState<CharacterDto> viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> loadCharacterDetail(int characterId) async {
    _setViewState(ViewState.loading());
    final detail = await _getCharacterDetail.call(
        params: GetCharacterDetailParams(characterId));
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
