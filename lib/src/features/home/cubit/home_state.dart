import 'package:uzum_market/src/features/home/model/product_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccesState extends HomeState {
  final List<ProductModel> products;

  HomeSuccesState({required this.products});
}

class HomeInitialState extends HomeState {}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message,);
}
