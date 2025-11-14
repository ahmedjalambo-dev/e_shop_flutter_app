import 'package:e_shop_flutter_app/features/home/data/models/categories_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = Loading;
  const factory CategoriesState.success(CategoriesResponse categoriesResponse) =
      Success;
  const factory CategoriesState.failure(String message) = Failure;
}
