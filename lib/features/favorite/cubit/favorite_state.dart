import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = _Initial;
  const factory FavoriteState.loading() = Loading;
  const factory FavoriteState.loaded(
    List<Product> favorites,
    Set<String> favoriteProductIds,
  ) = Loaded;
  const factory FavoriteState.error(String message) = Error;
}
