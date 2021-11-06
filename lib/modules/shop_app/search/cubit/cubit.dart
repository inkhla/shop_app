
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../../constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchData({
    String? text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text' : text,
      },
      token: token!,
    ).then((value) {
      emit(SearchSuccessState());
      searchModel = SearchModel.fromJson(value.data);
      print(value.data.toString());
    }).catchError((error) {
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}
