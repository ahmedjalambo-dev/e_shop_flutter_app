import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit/categories_state.dart';
import 'package:e_shop_flutter_app/features/home/data/repos/categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo;
  CategoriesCubit(this._categoriesRepo)
    : super(const CategoriesState.initial());
}
