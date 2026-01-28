import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uzum_market/src/features/home/model/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    loadProducts(limit: 5, currentState: HomeLoadingState());
  }
  bool hasMore = true;
  DocumentSnapshot? lastDocument;
  Future<void> loadProducts({
    required int limit,
    required dynamic currentState,
  }) async {
    if (state is HomeInitialState) {
      emit(HomeLoadingState());
    }
    try {
      if (hasMore == false) {
        return;
      }
      Query collection = FirebaseFirestore.instance
          .collection('products')
          .limit(limit);

      if (lastDocument != null) {
        collection = collection.startAfterDocument(lastDocument!);
      }

      final snap = await collection.get();

      if (snap.docs.isEmpty) {
        hasMore = false;
        return;
      }

      lastDocument = snap.docs.last;

      List<ProductModel> data = currentState.runtimeType == HomeSuccesState
          ? (state as HomeSuccesState).products
          : [];

      for (var i = 0; i < snap.docs.length; i++) {
        data.add(
          ProductModel.fromJson(snap.docs[i].data() as Map<String, dynamic>),
        );
      }

      emit(HomeSuccesState(products: data));

      if (snap.docChanges.length < limit) {
        hasMore = false;
      }
    } on TimeoutException catch (_) {
      emit(HomeErrorState('Server is down or slow connection !'));
    } on SocketException catch (_) {
      emit(HomeErrorState('No internet connection !'));
    } on FirebaseException catch (_) {
      emit(HomeErrorState("Something went wrong"));
    } catch (e) {
      emit(HomeErrorState('Something went wrong !'));
    }
  }

}
