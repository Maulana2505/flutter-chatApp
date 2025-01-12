import 'package:chatapp/features/search/domain/usecase/search_usecase.dart';
import 'package:chatapp/features/search/presentation/bloc/search_event.dart';
import 'package:chatapp/features/search/presentation/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsecase _searchUsecase;
  SearchBloc(this._searchUsecase) : super(SearchInitialState()) {
    on<SearchLoadEvent>(_loadData);
  }
  void _loadData(SearchLoadEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    final data = await _searchUsecase.call(event.query);
    data.fold(
      (l) => emit(SearchErrorState(l.massage)),
      (r) => emit(SearchLoadState(r)),
    );
  }
}
