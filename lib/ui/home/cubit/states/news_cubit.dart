import 'package:faculty/data/models/response/newsModel.dart';
import 'package:faculty/data/remote/api/api_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsSuccessState extends NewsStates {
  final List<NewsModel> news;
 
  NewsSuccessState(this.news);
}

class NewsErrorState extends NewsStates {
  final String error;

  NewsErrorState(this.error);
}


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState()) {
    getNews();
  }

  void getNews() async {
    emit(NewsLoadingState());
    try {
      final news = await ApiManager.getNews();
      emit(NewsSuccessState(news));
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }
}