import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_state.dart';
import 'package:e_shop_flutter_app/features/home/data/repos/categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo;
  CategoriesCubit(this._categoriesRepo)
    : super(const CategoriesState.initial());

  Future<void> emitCategoriesStates() async {
    emit(const CategoriesState.loading());
    final response = await _categoriesRepo.getCategories();
    response.when(
      success: (categoriesResponse) =>
          emit(CategoriesState.success(categoriesResponse)),
      failure: (error) => emit(
        CategoriesState.failure(
          error.apiErrorModel.message ?? 'An error occurred',
        ),
      ),
    );
  }
}
