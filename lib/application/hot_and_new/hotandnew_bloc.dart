import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';

part 'hotandnew_event.dart';
part 'hotandnew_state.dart';
part 'hotandnew_bloc.freezed.dart';

@injectable
class HotandnewBloc extends Bloc<HotandnewEvent, HotandnewState> {
  final HotAndNewService _hotAndNewService;
  HotandnewBloc(this._hotAndNewService) : super(HotandnewState.initial()) {
    //get hot and movie data
    on<LoadDataInComingSoon>(
      (event, emit) async {
        //send loading to the ui
        emit(const HotandnewState(
            comingsoonList: [],
            everyOneIsWatchingList: [],
            isLoading: true,
            hasError: false));
//get data from remot
        final _result = await _hotAndNewService.getHotAndNewMovieData();
        //data to state
        final newState = _result.fold(
          (MainFailure failure) {
            return const HotandnewState(
                comingsoonList: [],
                everyOneIsWatchingList: [],
                isLoading: false,
                hasError: true);
          },
          (HotAndNew resp) {
            return HotandnewState(
                comingsoonList: resp.results,
                everyOneIsWatchingList: state.everyOneIsWatchingList,
                isLoading: false,
                hasError: false);
          },
        );
        emit(newState);
      },
    );

    //get hot and tv data
    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //send loading to the ui
      emit(const HotandnewState(
          comingsoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
//get data from remot
      final _result = await _hotAndNewService.getHotAndNewTvData();
      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotandnewState(
              comingsoonList: [],
              everyOneIsWatchingList: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNew resp) {
          return HotandnewState(
              comingsoonList: state.comingsoonList,
              everyOneIsWatchingList: resp.results,
              isLoading: false,
              hasError: false);
        },
      );
      emit(newState);
    });
  }
}
