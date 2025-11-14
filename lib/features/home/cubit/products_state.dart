import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = Loading;
  const factory ProductsState.success(ProductsResponse productsResponse) =
      Success;
  const factory ProductsState.failure(String message) = Failure;
}
